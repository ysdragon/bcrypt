/* Ring Bcrypt Extension */

#include "blf.h"
#include "ring.h"
#include <stdlib.h>
#include <string.h>


/* Utility function to validate salt */
static int validate_salt(const char *salt)
{
	if (!salt || *salt != '$')
	{
		return 0;
	}

	/* discard $ */
	salt++;

	if (*salt > BCRYPT_VERSION)
	{
		return 0;
	}

	if (salt[1] != '$')
	{
		switch (salt[1])
		{
		case 'a':
		case 'b':
			salt++;
			break;
		default:
			return 0;
		}
	}

	/* discard version + $ */
	salt += 2;

	if (salt[2] != '$')
	{
		return 0;
	}

	int n = atoi(salt);
	if (n > 31 || n < 0)
	{
		return 0;
	}

	if (((u_int8_t)1 << (u_int8_t)n) < BCRYPT_MINROUNDS)
	{
		return 0;
	}

	salt += 3;
	if (strlen(salt) * 3 / 4 < BCRYPT_MAXSALT)
	{
		return 0;
	}

	return 1;
}

/* ring_bcrypt_gensalt_sync(minor_version, rounds, seed) */
/* Returns: salt string */
RING_FUNC(ring_bcrypt_gensalt_sync)
{
	char salt[_SALT_LEN];
	const char *minor_ver_str;
	char minor_ver;
	int rounds;
	u_int8_t *seed;
	unsigned int seed_size;

	if (RING_API_PARACOUNT != 3)
	{
		RING_API_ERROR(RING_API_MISS3PARA);
		return;
	}

	if (!RING_API_ISSTRING(1))
	{
		RING_API_ERROR("First parameter must be a string (minor version)");
		return;
	}

	if (!RING_API_ISNUMBER(2))
	{
		RING_API_ERROR("Second parameter must be a number (rounds)");
		return;
	}

	if (!RING_API_ISSTRING(3))
	{
		RING_API_ERROR("Third parameter must be a string (seed - 16 bytes)");
		return;
	}

	minor_ver_str = RING_API_GETSTRING(1);
	minor_ver = minor_ver_str[0];
	rounds = (int)RING_API_GETNUMBER(2);
	seed = (u_int8_t *)RING_API_GETSTRING(3);
	seed_size = RING_API_GETSTRINGSIZE(3);

	if (seed_size != 16)
	{
		RING_API_ERROR("Seed must be exactly 16 bytes");
		return;
	}

	bcrypt_gensalt(minor_ver, rounds, seed, salt);
	RING_API_RETSTRING(salt);
}

/* ring_bcrypt_hash(data, salt) */
/* Returns: hashed password string */
RING_FUNC(ring_bcrypt_hash)
{
	char bcrypted[_PASSWORD_LEN];
	const char *data;
	const char *salt;
	unsigned int data_len;

	if (RING_API_PARACOUNT != 2)
	{
		RING_API_ERROR(RING_API_MISS2PARA);
		return;
	}

	if (!RING_API_ISSTRING(1))
	{
		RING_API_ERROR("First parameter must be a string (data)");
		return;
	}

	if (!RING_API_ISSTRING(2))
	{
		RING_API_ERROR("Second parameter must be a string (salt)");
		return;
	}

	data = RING_API_GETSTRING(1);
	data_len = RING_API_GETSTRINGSIZE(1);
	salt = RING_API_GETSTRING(2);

	if (!validate_salt(salt))
	{
		RING_API_ERROR("Invalid salt. Salt must be in the form of: $Vers$log2(NumRounds)$saltvalue");
		return;
	}

	bcrypt(data, data_len, salt, bcrypted);
	RING_API_RETSTRING(bcrypted);
}

/* ring_bcrypt_compare(data, hash) */
/* Returns: 1 if match, 0 if not */
RING_FUNC(ring_bcrypt_compare)
{
	char bcrypted[_PASSWORD_LEN];
	const char *data;
	const char *hash;
	unsigned int data_len;
	int result;

	if (RING_API_PARACOUNT != 2)
	{
		RING_API_ERROR(RING_API_MISS2PARA);
		return;
	}

	if (!RING_API_ISSTRING(1))
	{
		RING_API_ERROR("First parameter must be a string (data)");
		return;
	}

	if (!RING_API_ISSTRING(2))
	{
		RING_API_ERROR("Second parameter must be a string (hash)");
		return;
	}

	data = RING_API_GETSTRING(1);
	data_len = RING_API_GETSTRINGSIZE(1);
	hash = RING_API_GETSTRING(2);

	result = 0;

	if (validate_salt(hash))
	{
		bcrypt(data, data_len, hash, bcrypted);
		result = (strcmp(bcrypted, hash) == 0);
	}

	RING_API_RETNUMBER(result);
}

/* ring_bcrypt_get_rounds(hash) */
/* Returns: number of rounds used in hash */
RING_FUNC(ring_bcrypt_get_rounds)
{
	const char *hash;
	u_int32_t rounds;

	if (RING_API_PARACOUNT != 1)
	{
		RING_API_ERROR(RING_API_MISS1PARA);
		return;
	}

	if (!RING_API_ISSTRING(1))
	{
		RING_API_ERROR("Parameter must be a string (hash)");
		return;
	}

	hash = RING_API_GETSTRING(1);
	rounds = bcrypt_get_rounds(hash);

	if (rounds == 0)
	{
		RING_API_ERROR("Invalid hash provided");
		return;
	}

	RING_API_RETNUMBER(rounds);
}

RING_LIBINIT
{
	RING_API_REGISTER("bcrypt_gensalt_sync", ring_bcrypt_gensalt_sync);
	RING_API_REGISTER("bcrypt_hash", ring_bcrypt_hash);
	RING_API_REGISTER("bcrypt_compare", ring_bcrypt_compare);
	RING_API_REGISTER("bcrypt_get_rounds", ring_bcrypt_get_rounds);
}
