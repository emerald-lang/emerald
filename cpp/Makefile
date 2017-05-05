CXX = g++ -std=c++14
CXXFLAGS = -Wall -O -g -stdlib=libc++
OBJECTS = src/main.cpp src/grammar.cpp src/preprocessor.cpp
LIBS = -L/usr/local/lib/ -lboost_system-mt
EXEC = emerald

${EXEC} : ${OBJECTS}
	${CXX} ${OBJECTS} ${CXXFLAGS} -o ${EXEC} ${LIBS}

clean:
	rm $(EXEC)
