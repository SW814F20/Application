# Todo
- [ ] Move runners to be per document, instead of per package - use prefix as name collision protection in codegen.
- [ ] Move helpers to be per document, instead of per package - use prefix as name collision protection in codegen.

# Running Code Coverage
For code coverage we use the [test_coverage](https://pub.dev/packages/test_coverage) package. 

To compile the test coverage:
`pub run test_coverage`

This will generate a lcov file in `coverage/lcov.info`. 
If you have lcov installed you can convert this to a html page by using `genhtml -o coverage coverage/lcov.info`,
and open it using `open coverage/index.html`.

## Install lcov
### Ubuntu
`sudo apt-get update && apt-get install lcov`

### MacOS (requires homebrew)
install homebrew `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`
then run: 

`brew install lcov`

### Windows
Im not sure, try to find a port :P