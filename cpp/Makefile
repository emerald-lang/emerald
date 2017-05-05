CXX = g++ -std=c++14
CXXFLAGS = -Wall -O -g -stdlib=libc++
OBJECTS = src/grammar.cpp src/preprocessor.cpp
CLI_OBJECTS = src/main.cpp 
TESTS = $(wildcard test/*.cpp)
LIBS = -I/usr/local/include -L/usr/local/lib
EXEC = emerald
TEST_EXEC = emerald_test

${EXEC} : ${CLI_OBJECTS} ${OBJECTS}
	${CXX} ${OBJECTS} ${CXXFLAGS} -o ${EXEC} ${LIBS}

${TEST_EXEC}: ${OBJECTS} ${TESTS}
	${CXX} ${OBJECTS} ${TESTS} ${CXXFLAGS} -o ${TEST_EXEC} ${LIBS}

test: ${TEST_EXEC}
	./${TEST_EXEC}

clean:
	rm $(EXEC)
