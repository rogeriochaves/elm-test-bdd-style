test: runner

runner:
	elm-make test/TestRunner.elm --output test.js && node test.js
