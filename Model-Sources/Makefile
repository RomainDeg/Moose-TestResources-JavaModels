#VerveineJ path (add it if you want to edit the testing models)
VerveineJPath = 

all :	model_lib model_main

clear :
	rm -r library_project/bin

compile_lib :
	javac -d library_project/bin library_project/src/library/blabla/* 

jar : compile_lib
	cd library_project/bin && \
	jar -cvf library_project.jar library/* && \
	jar -i library_project.jar

model_main : jar
	java -jar $(VerveineJPath) -anchor assoc -autocp library_project/bin -format mse -o main_project/src/main_project.mse ./main_project/src

# model_main : jar
#	docker run -v ./main_project/src:/src -v ./library_project/bin:/dependencies ghcr.io/evref-bl/verveinej:v3.3.1 -format mse -o main_project.mse -anchor assoc
	
model_lib :
	java -jar $(VerveineJPath) -anchor assoc -format mse -o library_project/src/library_project.mse ./library_project/src

model_lib_docker :
	docker run -v ./library_project/src:/src ghcr.io/evref-bl/verveinej:v3.3.1 -format mse -o library_project.mse -anchor assoc
