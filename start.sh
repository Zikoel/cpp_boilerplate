#!/bin/bash

template=${1:-"NONE"}
projName=${2:-"DUMB"}
path=${3:-"./pathGoHere"}

if [ ${template} = "NONE" ];
   then
   echo -e "Template available:"
   ls  -d */
   exit
fi

echo -e "creating project: ${projName}"
echo -e "        template: ${template}"
echo -e "            path: ${path}\n"

# check if path exists; if not, create a new directory and warn the user
if [ ! -d ${path} ];
   then
   mkdir ${path}
   echo -e "***WARNING*** directory ${path} has been created right now; going on\n"
fi


# check if the template exists; if not, print error and exit
if [ ! -d ${template} ];
   then
   echo -e "***FATAL*** template ${template} not found, specify an existing one\n"
   exit
fi

# check if project already exists in the given path; if yes, abort process
if [ -d ${path}/${projName} ];
   then
   echo -e "***FATAL*** project with name ${projName} already exists in ${path}; stopping here\n"

   # if project is new, then create the package structure
else

    mkdir ${path}/${projName}
    cp -r ${template}/. ${path}/${projName}

    # creating ChangeLog
    sed -i 's/___project_name___/'${projName}'/g' ${path}/${projName}/CMakeLists.txt

    echo -e "***INFO*** project ${projName} created: "
    ls -lrtRA ${path}/${projName}
    echo -e "***INFO*** enter the project folder and start working \n"
fi