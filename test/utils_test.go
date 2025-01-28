package test_test

import (
	"encoding/base64"
	"fmt"
	"strconv"
	"testing"

	"github.com/IbraSuraya/suraya/config"
	"github.com/IbraSuraya/suraya/utils"
	"github.com/stretchr/testify/assert"
)

func TestViper(t *testing.T) {
	viper := config.NewViper()
	t.Run("Success key found", func(t *testing.T) {
		size_salt, _ := strconv.Atoi(viper.GetString("utils.pass.size_salt"))
		assert.Equal(t, 16, size_salt)
	})
	t.Run("Failed key not found", func(t *testing.T) {
		size_salt, _ := strconv.Atoi(viper.GetString("utils.pass.not_found"))
		assert.Equal(t, 0, size_salt)
	})
}

func TestCreate_Salt(t *testing.T) {
	t.Run("Success Generate Salt", func(t *testing.T) {
		salt, err := utils.GenerateSalt(16)
		assert.Nil(t, err)
		assert.NotNil(t, salt)
		assert.Len(t, salt, 16)
	})
}

func TestCreate_Key(t *testing.T) {
	t.Run("Success Generate Key", func(t *testing.T) {
		salt, err := utils.GenerateKeyEncrypt(16)
		assert.Nil(t, err)
		assert.NotNil(t, salt)
		assert.Len(t, salt, 16)
	})
}

// hashLen : 44 | saltLen : 24
// n Char pass_plain >= 0
func TestHash_Argon2(t *testing.T) {
	t.Run("Success Hash and Success Verif", func(t *testing.T) {
		viper := config.NewViper()
		data := "currentpassword3"
		hashed, salt, err := utils.HashArgon2(data, viper)

		fmt.Printf("data (%v) : %v\n", len(data), data)
		fmt.Printf("Hashed Pass (%v) : %v\n", len(hashed), hashed)
		fmt.Printf("Salt (%v) : %v\n", len(salt), salt)
		isValid := utils.VerifyArgon2(data, hashed, salt, viper)

		assert.NotNil(t, viper)
		assert.Len(t, hashed, 44)
		assert.Len(t, salt, 24)
		assert.Nil(t, err)
		assert.True(t, isValid)
	})
	t.Run("Success Hash and Failed Verif", func(t *testing.T) {
		viper := config.NewViper()
		data := "rahasia"
		hashed, salt, err := utils.HashArgon2(data, viper)
		isValid := utils.VerifyArgon2("Salah", hashed, salt, viper)

		assert.NotNil(t, viper)
		assert.Len(t, hashed, 44)
		assert.Len(t, salt, 24)
		assert.Nil(t, err)
		assert.False(t, isValid)
	})
	t.Run("Just Success Verif", func(t *testing.T) {
		viper := config.NewViper()
		data := "rahasia"
		hashed := "lVPK2BvK4qwc2zgv8JSNhMsLGhReTINGFK37joGzkV0="
		salt := "mdXAL7Qb61ojog1x09kcRw=="

		isValid := utils.VerifyArgon2(data, hashed, salt, viper)

		assert.NotNil(t, viper)
		assert.Len(t, hashed, 44)
		assert.Len(t, salt, 24)
		assert.True(t, isValid)
	})
}

// ibrasuraya@example.com	(25) : 56+16(Nonce) | 32(Key)
// 123-456-7890 							(12) : 40+16(Nonce) | 32(Key)
func TestEncrypt_AES_256_GCM(t *testing.T) {
	viper := config.NewViper()
	size_key, _ := strconv.Atoi(viper.GetString("utils.pass.AES_256_GCM.size_key"))
	data := "123-456-7890"
	// data := "ibrasuraya@example.com"
	t.Run("success encrypt and success decrypt", func(t *testing.T) {
		key, err := utils.GenerateKeyEncrypt(size_key)
		assert.Nil(t, err)

		// Encrypt
		encrypted, nonce, err := utils.EncryptAES(data, viper, key)
		assert.NotNil(t, viper)
		assert.Nil(t, err)
		assert.NotNil(t, encrypted)
		assert.Len(t, nonce, 16)
		assert.Len(t, key, 32)

		fmt.Printf("Data (%v) : %v \n", len(data), data)
		fmt.Printf("Encrypted (%v) : %v \n", len(encrypted), encrypted)
		fmt.Printf("Nonce (%v) : %v \n", len(nonce), nonce)
		fmt.Printf("Key (%v) : %v \n", len(key), key)
		
		key_aes := nonce + base64.StdEncoding.EncodeToString(key)
		fmt.Printf("Key_aes (%v) : %v \n", len(key_aes), key_aes)
		nonce_base := key_aes[:16]
		key_base, err := base64.StdEncoding.DecodeString(key_aes[16:])
		assert.Nil(t, err)
		// Dekripsi
		decrypted, err := utils.DecryptAES(encrypted, nonce_base, key_base)
		fmt.Printf("Decrypted (%v) : %v \n", len(decrypted), decrypted)
		assert.Nil(t, err)
		assert.Equal(t, data, decrypted)
	})
	t.Run("success encrypt and failed decrypt (nonce wrong)", func(t *testing.T) {
		key, err := utils.GenerateKeyEncrypt(size_key)
		assert.Nil(t, err)

		// Encrypt
		encrypted, nonce, err := utils.EncryptAES(data, viper, key)
		assert.NotNil(t, viper)
		assert.Nil(t, err)
		assert.NotNil(t, encrypted)
		assert.Len(t, nonce, 16)
		assert.Len(t, key, 32)

		key_aes := nonce + base64.StdEncoding.EncodeToString(key)
		// nonce_base := key_aes[:16]
		key_base, err := base64.StdEncoding.DecodeString(key_aes[16:])
		assert.Nil(t, err)
		
		// Dekripsi
		decrypted, err := utils.DecryptAES(encrypted, "salah", key_base)
		assert.NotNil(t, err)
		assert.Equal(t, "", decrypted)
	})
	t.Run("success encrypt and failed decrypt (key wrong)", func(t *testing.T) {
		key, err := utils.GenerateKeyEncrypt(size_key)
		assert.Nil(t, err)

		// Encrypt
		encrypted, nonce, err := utils.EncryptAES(data, viper, key)
		assert.NotNil(t, viper)
		assert.Nil(t, err)
		assert.NotNil(t, encrypted)
		assert.Len(t, nonce, 16)
		assert.Len(t, key, 32)

		key_aes := nonce + base64.StdEncoding.EncodeToString(key)
		nonce_base := key_aes[:16]
		// key_base, err := base64.StdEncoding.DecodeString(key_aes[16:])
		// assert.Nil(t, err)

		// Dekripsi
		decrypted, err := utils.DecryptAES(encrypted, nonce_base, []byte("wrong"))
		assert.NotNil(t, err)
		assert.Equal(t, "", decrypted)
	})
	t.Run("success encrypt key kunci and success decrypt", func(t *testing.T) {
		key := []byte("kuncikuncikuncikuncikuncikunciku")

		// Encrypt
		encrypted, nonce, err := utils.EncryptAES(data, viper, key)
		assert.NotNil(t, viper)
		assert.Nil(t, err)
		assert.NotNil(t, encrypted)
		assert.Len(t, nonce, 16)
		assert.Len(t, key, 32)

		key_aes := nonce + base64.StdEncoding.EncodeToString(key)
		nonce_base := key_aes[:16]
		key_base, err := base64.StdEncoding.DecodeString(key_aes[16:])
		assert.Nil(t, err)

		// Dekripsi
		decrypted, err := utils.DecryptAES(encrypted, nonce_base, key_base)
		assert.Nil(t, err)
		assert.Equal(t, data, decrypted)
	})
	t.Run("just success decrypt", func(t *testing.T) {
		// encrypted := "1Qpbq1FzfetOdfvuKfT2T3Ps/G17JCAUswBu/lrsyD0T1xaR2uM="
		encrypted := "YQNiu+/5to54sVlqf1Fijam4V5+oB7fXnmOQsg=="
		// nonce := "FHaDL3dO3oYST1RX"
		nonce := "csJGxMazHQQJdU0o"
		// key := []byte{189,106,193,95,230,67,39,158,69,170,36,50,127,242,116,55,147,106,250,141,222,127,220,114,226,234,30,1,38,71,98,197}
		key := []byte{78,216,88,41,50,20,228,91,89,59,116,146,10,82,245,220,201,186,73,189,8,86,110,184,81,104,91,56,254,224,9,53}

		key_aes := nonce + base64.StdEncoding.EncodeToString(key)
		nonce_base := key_aes[:16]
		key_base, err := base64.StdEncoding.DecodeString(key_aes[16:])
		assert.Nil(t, err)

		// Dekripsi
		decrypted, err := utils.DecryptAES(encrypted, nonce_base, key_base)
		assert.Nil(t, err)
		assert.Equal(t, data, decrypted)
	})
}

func TestAjh(t *testing.T) {
	a := "a"
	b := "b"
	c := a + b
	fmt.Println(c)
}

func TestCreate_Slug(t *testing.T){
	fName := "ibra"
	lName := "suraya"
	assert.Equal(t, "ibra-suraya", utils.GenerateSlugUser(fName, lName))
}
