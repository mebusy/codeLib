#!python3

"""
This script is used to modify unity3d project files to be compatible with omnisharp.
It will remove the <ProjectReference> in <ItemGroup> from .csproj files

BUT this solution is not good enough...
The most simple and better way is
0. delete the .sln file
1. dotnet new sln --name mySolution
2. dotnet sln add <the most important>.csproj
3. edit that .csproj,
    remove all <Compile Include="xxx" />
    add <Compile Include="Assets/Scripts/**/*.cs" />

    delete all <ProjectReference>
"""

import os
import re
import sys

# re pattern to match the xml <ProjectReference...  </ProjectReference> tag
projectReferencePattern = re.compile(
    r'<ProjectReference Include="(.*?)">.*?</ProjectReference>', re.DOTALL
)

tmplRefSrcFile = """
<ItemGroup>
    %s
</ItemGroup>
</Project>
"""

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(
            "Usage: python unityOmnisharpClean.py <.sln file or dirctory contains sln file>"
        )
        sys.exit(1)

    slnFile = sys.argv[1]
    # if slnFile is a directory, find the sln file in the directory
    if os.path.isdir(slnFile):
        for file in os.listdir(slnFile):
            if file.endswith(".sln"):
                slnFile = os.path.join(slnFile, file)
                print(f"Found sln file: {slnFile}")
                break

    if not os.path.exists(slnFile):
        print(f"File {slnFile} does not exist")
        sys.exit(1)

    # read the sln file
    with open(slnFile, "r") as f:
        lines = f.readlines()

    # find the project files
    projectFiles = []
    for line in lines:
        if line.startswith("Project("):
            projectFiles.append(line.split(",")[1].strip().strip('"'))

    # find the .csproj files
    csprojFiles = [file for file in projectFiles if file.endswith(".csproj")]

    # print(f"Found {len(csprojFiles)} .csproj files", csprojFiles)

    # map: full path of .csproj file -> list of <Compile Include="...">
    csprojSrcFiles = {}

    # extract the path of the slnFile
    slnPath = os.path.dirname(slnFile)

    # find all <Compile Include="..."> in each .csproj file
    for fname in csprojFiles:
        file = os.path.join(slnPath, fname)
        with open(file) as f:
            data = f.read()

        # find all Compile Include .cs file
        compileIncludePattern = re.compile(r'(<Compile Include="Assets/.*?" />)')
        compileInclude = compileIncludePattern.findall(data)
        # print(compileInclude)
        csprojSrcFiles[file] = compileInclude

    for fname in csprojFiles:
        file = os.path.join(slnPath, fname)
        with open(file) as f:
            data = f.read()

        csprojPath = os.path.dirname(file)

        srcFilesInRef = []
        projectReference = projectReferencePattern.findall(data)
        for ref in projectReference:
            refFile = os.path.join(csprojPath, ref)
            if refFile in csprojSrcFiles:
                srcFilesInRef.extend(csprojSrcFiles[refFile])

        # print(f"extra {len(srcFilesInRef)} src files for {fname}")

        with open(file, "w") as f:
            # remove all <ProjectReference>...</ProjectReference>
            data = projectReferencePattern.sub("", data)
            # replace last </Project> with tmplRefSrcFile
            data = data.rsplit("</Project>", 1)[0] + tmplRefSrcFile % "\n".join(
                srcFilesInRef
            )
            f.write(data)

        # print(f"Modified {file}")

    print("done")
