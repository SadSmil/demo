Feature: ajouter produit

Background:
    * url 'https://api.efi-academy.com/user-api/public'

    * def Faker = Java.type('com.github.javafaker.Faker')
    * def faker = new Faker()
    * def name = faker.name().name()
    * def email = faker.internet().emailAddress()
    * def password = faker.internet().password()
    * def randomNum = faker.number().numberBetween(0, 100)
    * def role = randomNum < 40 ? 'user' : 'admin'
    * def code_att = randomNum < 40 ? 403 : 201
    * def stock = faker.number().numberBetween(10,50)
    * def prix = faker.number().numberBetween(200,1000)
    * def image_url = faker.avatar().image()

@creation
#REGISTER
Scenario: ajout produit
    * def register =
      """
        {
          "name": "#(name)",
          "email": "#(email)",
          "password": "#(password)",
          "role": "#(role)"
        }
      """
    * print "register.role"

    Given path 'register'
    And request register
    When method post
    Then status 201

    # * def response = response.user

    # And match response.name == register.name
    # And match response.email == register.email
    # And match response.role == register.role

# LOGIN
    Given path 'login'
    * def body_post = 
     """
      {
        "email": "#(register.email)",
        "password": "#(register.password)"
      }
      """
    And request body_post
    When method post
    Then status 200
    And match response.success == true

    * def token = response.token
    * print 'Token : ', token



     # PRODUIT
    Given path 'products'
    * def body_product =
     """
      {
        "name": "Webcam HD",
        "description": "Webcam 1080p",
        "price": "#(prix)",
        "stock": "#(stock)",
        "image_url": "#(image_url)"
      }
      """
    And header Authorization = 'Bearer ' + token
    And request body_product
    When method post
    Then match responseStatus == code_att