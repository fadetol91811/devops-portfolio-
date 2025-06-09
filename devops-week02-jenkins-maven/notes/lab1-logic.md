# Lab Challenge 1 – Maven Dependency Conflict Resolution

**Objective:** Simulate and resolve a version conflict between two Spring dependencies.

## Key Concepts:
- `spring-web:5.3.10` depends transitively on `spring-core`.
- We manually added `spring-core:4.3.0.RELEASE` to simulate a conflict.
- We used `<dependencyManagement>` to force Maven to resolve `spring-core` to `5.3.10`.

## Validation:
- `mvn dependency:tree` shows `spring-core:5.3.10` is selected despite older declared version.
- Conflict successfully overridden via `dependencyManagement`.

## Outcome:
✅ Build success  
✅ Conflict override validated in output

