package test_test

import (
	"fmt"
	"strconv"
	"testing"

	"github.com/IbraSuraya/suraya/config"
	"github.com/IbraSuraya/suraya/utils"
)

func TestViper(t *testing.T) {
	viper := config.NewViper()

	size_salt, _ := strconv.Atoi(viper.GetString("utils.pass.size_salt"))
	fmt.Println(size_salt)
}

func TestCreate_Salt(t *testing.T) {
	salt, err := utils.GenerateSalt(16)
	if err != nil {
		t.Logf("Generated Failed")
		return
	}
	fmt.Println(salt)
}

// hashLen : 44 | saltLen : 24
func TestHash_Argon2 (t *testing.T) {
	pass_plain := "rahasia"
	hashed, salt, err := utils.HashArgon2(pass_plain)
	if err != nil {
		t.Logf("%s", err.Error())
	}

	fmt.Printf("Hashed Pass (%v) : %v\n", len(hashed), hashed)
	fmt.Printf("Salt (%v) : %v\n", len(salt), salt)

	isValid := utils.VerifyArgon2(pass_plain, hashed, salt)
	fmt.Println("Valid : ", isValid)
}
