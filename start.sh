#!/bin/bash

template=${1:-"cxxopts_quick"}
projName=${2:-"DUMB"}
path=${3:-"./pathGoHere"}

echo -e "\n\t creating project: ${projName}"
echo -e "  \t         template: ${template}"
echo -e "  \t             path: ${path}"


# check if path exists; if not, create a new directory and warn the user
if [ ! -d ${path} ];
   then
   mkdir ${path}
   echo -e "\n\t ***WARNING*** directory ${path} has been created right now; going on\n\n"
fi


# check if the template exists; if not, print error and exit
if [ ! -d ${template} ];
   then
   echo -e "\n\t ***FATAL*** template ${template} not found, specify an existing one\n\n"
   exit
fi

# check if project already exists in the given path; if yes, abort process
if [ -d ${path}/${projName} ];
   then
   echo -e "\n\t ***FATAL***   project with name ${projName} already exists in ${path}; stopping here\n\n"

   # if project is new, then create the package structure
else

    mkdir ${path}/${projName}
    cp -r ${template}/* ${path}/${projName}

    # creating ChangeLog
    sed -i 's/___project_name___/'${projName}'/g' ${path}/${projName}/CMakeLists.txt

    echo -e "\n\t ***INFO***   project ${projName} created: "
    ls -lrtRA ${path}/${projName}
    echo -e "\n\n\t ***INFO***   enter the project folder and start working \n"
fi