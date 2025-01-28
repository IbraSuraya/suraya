package utils

import "fmt"

func GenerateSlugUser(fName, lName string) string {
	slug := fmt.Sprintf("%s-%s", fName, lName)
	return slug
}
