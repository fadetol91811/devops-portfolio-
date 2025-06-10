# Lab 1: Logic Breakdown & Reflections

## What Happened?
We created a version conflict between `spring-web` (v5.3.10) and `spring-core` (v4.3.0.RELEASE), which transitively conflicted with Maven resolution behavior.

## What Broke?
Jenkins pipeline initially failed due to malformed `pom.xml` and missing POM context in the workspace.

## How It Was Resolved
- Fixed `pom.xml` with correct `<project>` block
- Explicitly resolved the version conflict using `<dependencyManagement>`
- Defined proper `Jenkinsfile` stages:
  - `mvn clean compile`
  - `mvn dependency:tree`

## Key Lessons
- Maven builds fail hard on broken XML structure
- Jenkins must run from the correct subdirectory where `pom.xml` exists
- `dependencyManagement` is the official way to override transitive versions

## Real-World Relevance
This type of conflict is common in microservice projects with multiple dependencies. Being able to trace, visualize, and resolve them is a core SRE skill.

