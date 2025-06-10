# Lab 1: Maven Dependency Resolution Challenge

## Objective
Simulate and resolve a version conflict between two Spring dependencies using Maven's dependency tree and Jenkins Pipeline.

## Tasks
- Introduce a version conflict in `pom.xml`
- Visualize the conflict using `mvn dependency:tree`
- Resolve the conflict using `<dependencyManagement>`
- Automate verification through a Jenkins Pipeline build

## Commands Used
```bash
mvn dependency:tree
mvn compile

