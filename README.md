# Proyecto DCCinema Grupo 43
#### Entrega: 1
#### Url Heroku: https://dccinema-43.herokuapp.com/


### Logros
 Todo lo pedido; actions para rubocop, los tests y simplecov. Subido a heroku y eso.

### Consideraciones generales para la correcion

### Se cambió el codigo de test_helper.rb porque no podía agregar más de 50 test

```
module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors, threshold: 100)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
```

