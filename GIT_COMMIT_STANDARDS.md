# ***Git Commit Standards***

A clear and structured commit message is crucial for understanding the history of the project. These standards outline the format to follow for writing good commit messages, ensuring consistency and traceability throughout the codebase.

---

## 1. **Commit Message Structure**

Each commit message should consist of three parts:
- **Type**: What kind of change is this?
- **Scope (optional)**: What part of the code does this affect?
- **Subject**: A short description of the change (imperative mood).

### **Commit Message Template**:
```bash
<type>(<scope>): <subject>

feat(auth): add login with email and password
```


## 2. **Commit Types**
Use these types to categorize your commit messages:

#### 1. Feature:
```
feature: A new feature or functionality.
Example: feat(user-profile): add user avatar upload
```
#### 2. Bug Fix:
```
fix: A bug fix or issue resolution.
Example: fix(api): handle 404 error on user fetch
```

#### 3. Documentation Update:
```
docs: Documentation updates or changes.
Example: docs: update README with installation steps
```

#### 4. Style Change:
```
style: Changes that do not affect functionality (e.g., formatting, whitespace, etc.).
Example: style: format code with flutter format
```

#### 5. Refactor:
```
refactor: Code changes that neither fix a bug nor add a feature (e.g., code restructuring).
Example: refactor(auth): simplify login logic
```

#### 6. Test:
```
test: Adding or fixing tests.
Example: test: add unit tests for login view model
```

#### 7. Chore (Dependency Update):
```
chore: Maintenance tasks such as dependency updates or build process changes.
Example: chore(deps): update flutter to version 3.0.0
```

## 3. **Commit Scope (Optional)**
The scope specifies what part of the app is affected by the change. It’s optional but recommended for clarity, especially in larger codebases.

Example scopes:
- auth: for authentication-related code
- ui: for user interface changes
- api: for changes to network-related code
- repo: for repository-related changes
- test: for testing-related changes

##### **Example:**
```
fix(api): resolve timeout issue in user data fetch
```

## 4. **Subject Line**
- Keep it short and to the point: The subject should be 50 characters or less.
- Use the imperative mood: Imagine completing the sentence, "If applied, this commit will..." (e.g., "add new feature", "fix login bug").
- Avoid punctuation: No period at the end of the subject line.
- Be specific: Make sure the subject provides a clear and concise description of the change.

#### Good examples:

feat(ui): redesign login screen
fix(repo): correct user data repository method

#### Bad examples:

Update the login screen design. (Avoid periods)
Fixed a bug with the login functionality. (Avoid past tense)

## 5. **Body (Optional)**
The commit body can provide additional details about what and why the changes were made, especially if the change is non-trivial. The body should:
- Wrap lines at 72 characters.
- Explain the reason for the change.
- Reference any relevant issue numbers or links.

##### **Example:**
```
feat(user-profile): add user avatar upload

Added the ability for users to upload profile pictures. This feature
integrates with the cloud storage service to store the images.

Closes #345
```

## 6. **Breaking Changes**
If the commit introduces breaking changes (changes that break backward compatibility), use the BREAKING CHANGE tag in the commit body to explain the reason and impact.

##### **Example:**
```
feat(auth): update token management logic

BREAKING CHANGE: The method `getToken()` now returns a Future and has
been renamed to `fetchTokenAsync()`. All existing usages must be updated.
```

## 7. **Additional Guidelines**
- **Small Commits** : Make frequent, small commits to make the project’s history easier to follow.
- **Avoid “WIP” Commits** : Don’t use "Work In Progress" (WIP) commits in the main branch. Use feature branches for unfinished work.
- **Atomic Commits** : Ensure that each commit does one thing well. A commit should focus on a single task or bug fix.
- **Squash and Merge** : If a feature has multiple commits, it’s a good idea to squash them into a single commit before merging to keep the history clean.

## **Conclusion**
These Git commit standards help maintain a clean, readable, and maintainable commit history. By following these guidelines, you ensure that your changes are well-documented, easier to review, and understandable by anyone who revisits the codebase in the future.

```yaml
---

### Benefits of Using a Standard:

1. **Readability**: Easy for others to understand the intent of each commit.
2. **Traceability**: Helps trace the introduction of bugs or features more efficiently.
3. **Consistency**: Provides a consistent format across the entire team.

###By including these standards, you make the project's Git history more valuable, especially as it grows and more contributors work on it.
```