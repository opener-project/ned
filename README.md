# EHU-ned_kernel

This repository is contains the Named Entity Disambiguation tool based on DBpedia Spotlight.
Providing that a DBpedia Spotlight Rest server is running, the EHU-ned module will take
KAF as input (containing <entities> elements) and perform Named Entity Disambiguation
for each language within the OpeNER project.

Developed by IXA NLP Group (ixa.si.ehu.es) for the 7th Framework OpeNER European project.

### Contents

The contents of the repository are the following:

- core: directory containing the core of the EHU DBpedia Spotlight
    + src/ source files of EHU-ned
    + pom.xml modified pom.xml to install DBpedia Spotlight

- README.md: This README


## Installation Procedure

In a snapshot:

    1. Modify EHU-ned_kernel/core/pom.xml as specified below.
    2. Compile ehu-ned module with `mvn clean package`
    3. Start Rest server as specified [here](https://github.com/opener-project/EHU-DBpedia-Spotlight).
       cd dbpedia-spotlight/conf
       java -jar ../dist/target/dbpedia-spotlight-0.6-jar-with-dependencies.jar
    4. cat ner.kaf | EHU-ned_kernel/core/target/ehu-ned-1.0.jar -p $PORT_NUMBER


If you already have installed in your machine JDK7 and MAVEN 3, please go to step 3
directly. Otherwise, follow the detailed steps:

### 1. Install JDK 1.7

If you do not install JDK 1.7 in a default location, you will probably need to configure the PATH in .bashrc or .bash_profile:

    export JAVA_HOME=/yourpath/local/java17
    export PATH=${JAVA_HOME}/bin:${PATH}


If you use tcsh you will need to specify it in your .login as follows:

    setenv JAVA_HOME /usr/java/java17
    setenv PATH ${JAVA_HOME}/bin:${PATH}


If you re-login into your shell and run the command

    java -version


You should now see that your jdk is 1.7

### 2. Install MAVEN 3

Download MAVEN 3 from

    wget http://ftp.udc.es/apache/maven/maven-3/3.0.4/binaries/apache-maven-3.0.4-bin.tar.gz


Now you need to configure the PATH. For Bash Shell:

    export MAVEN_HOME=/home/ragerri/local/apache-maven-3.0.4
    export PATH=${MAVEN_HOME}/bin:${PATH}

For tcsh shell:

    setenv MAVEN3_HOME ~/local/apache-maven-3.0.4
    setenv PATH ${MAVEN3}/bin:{PATH}

If you re-login into your shell and run the command

    mvn -version


You should see reference to the MAVEN version you have just installed plus the JDK 7 that is using.

### 3. Download the repository

    git clone git@github.com:opener-project/EHU-ned_kernel.git

### 4. Modify pom.xml

Go to the core subdirectory:

    cd EHU-ned_kernel/core/

And modify the properties element of the pom.xml to point to where the dbpedia-spotlight jar is placed
as setup by [following these instructions](https://github.com/opener-project/EHU-DBpedia-Spotlight):

    <properties>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
            <!--maven variable which points to your local spotlight -->
            <internal.path>/home/user/dbpedia-spotlight/dist/target/</internal.path>
          </properties>

For example, if you installed dbpedia-spotlight in `/home/user/dbpedia-spotlight`, the binary
dbpedia-spotlight-0.6-jar-with-dependencies.jar directory will correspond to `/home/user/dbpedia-spotlight/dist/target/` as
specified in the <properties> element above.

### 5. Install EHU-ned

Once this path is correctly set, install the EHU-ned module

    mvn clean package

This command will create a `EHU-ned_kernel/core/target` directory containing the
ehu-ned-1.0.jar binary with all dependencies included.

### 6. EHU-ned USAGE

The ehu-ned-1.0.jar requires a KAF document containing <entities> elements as standard input and
provides Named Entity Disambiguation as standard output. It also requires the port number as argument. The language
is automatically identified from the KAF lang attribute. The port numbers assigned to each language are the following:

    - de: 2010
    - en: 2020
    - es: 2030
    - fr: 2040
    - it: 2050
    - nl: 2060

If you wanted to change the port numbers, please do so at the corresponding server_$lang.properties
in the [EHU-DBpedia-Spotlight](https://github.com/opener-project/EHU-DBpedia-Spotlight) repository. Note that
this will mean to re-install the mentioned repository.

**Once you have a [DBpedia Spotlight Rest server running](https://github.com/opener-project/EHU-DBpedia-Spotlight)** you
can send queries to it via the EHU-ned module as follows:

    cat ner.kaf | java -jar ehu-ned-1.0.jar -p $PORT_NUMBER

#### Contact information

    Rodrigo Agerri and Itziar Aldabe
    {rodrigo.agerri,itziar.aldabe}@ehu.es
    IXA NLP Group
    University of the Basque Country (UPV/EHU)
    E-20018 Donostia-San Sebastián

