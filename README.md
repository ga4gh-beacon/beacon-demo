# Beacon demo

This repository helps you setup a beacon demo in a docker container.

For convenience, we created a Makefile, that contains all the necessary commands.

## Step 1: Get the source files

Clone this repository to your machine

	git clone https://github.com/ga4gh-beacon/beacon-demo
	# and go inside
	cd beacon-demo

## Step 2: Compile the java code

This step is done on your machine, it is simpler than in a docker container.

Clone the repository (version 1.0.1):
	
	git clone https://github.com/ga4gh-beacon/beacon-elixir.git code
	cd code
	git checkout v1.0.1

Follow the instructions from the [reference implementation](https://github.com/ga4gh-beacon/beacon-elixir/tree/v1.0.1#managing-the-code)

# Step 3: Prepare the docker image

We use a Postgres database, running in a docker container. We add the jar file created with step 1, and load some data.

Copy the java target, the data to load and the database definitions to `/beacon`

	cd [back-to-this-repository]
	mkdir beacon
	cp code/elixir_beacon/target/elixir-beacon-1.0.1-SNAPSHOT.jar beacon/beacon.jar
	cp code/elixir_beacon/src/main/resources/application-dev.properties beacon/.
	cp -r code/elixir_beacon/src/main/resources/META-INF/1000_genomes_data beacon/data

The docker image is named `elixir/beacon` and is created with:

	make build

# Step 4: Instanciate a docker container from the image

Once the image is build, run:

	make up

If you want to follow what is happening:

	make log

You can then contact the beacon with:

	curl http://localhost:9075/elixirbeacon/v1.0.1/beacon/

Or open a web browser at the above URL

Here are a few [other examples of queries](https://github.com/ga4gh-beacon/beacon-elixir/tree/v1.0.1#beaconquery):

* http://localhost:9075/elixirbeacon/v1.0.1/beacon/query?referenceName=Y&start=2655179&referenceBases=G&alternateBases=A&assemblyId=GRCh37&includeDatasetResponses=NONE
* http://localhost:9075/elixirbeacon/v1.0.1/beacon/query?variantType=DUP&referenceName=21&startMin=45039444&startMax=45039445&endMin=45084561&endMax=45084562&referenceBases=T&assemblyId=GRCh37&includeDatasetResponses=ALL
* http://localhost:9075/elixirbeacon/v1.0.1/beacon/query?variantType=DEL&referenceName=21&start=15399042&end=15419114&referenceBases=T&assemblyId=GRCh37&includeDatasetResponses=ALL

# Step 5: Tear down everything

	make down
	

----
# Note

For the moment, it's all in one docker container.

We plan on separating the database from the beacon controller in a future release.
