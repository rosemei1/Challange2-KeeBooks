# GitHub Collaboration Guide

This repository uses a collaborative Git workflow to keep development organized, stable, and easy to maintain.

---

# Branch Strategy

## `main`
- Production-ready branch
- Only stable and tested code
- Never develop directly on `main`

## `development`
- Main active development branch
- All feature branches are created from here
- Always pull latest changes from this branch before starting work

---

# Branch Naming Convention

Use branch names with this format:

```txt
name/type:short-description
```

Examples:

```txt
fuad/feat:add-map
andi/fix:login-error
budi/docs:update-readme
```

Branch type examples:

| Type | Description |
|---|---|
| feat | New feature |
| fix | Bug fix |
| docs | Documentation |
| refactor | Code restructuring |
| test | Testing |
| chore | Maintenance |

---

# Important Team Habits

## Always Check Current Branch Before Editing

Before coding, check your branch:

```bash
git branch
```

or

```bash
git status
```

Make sure you are NOT working directly on:

```bash
main
```

---

## Always Pull Latest `development`

Before creating a new branch:

```bash
git checkout development
git pull origin development
```

Then create your branch:

```bash
git checkout -b fuad/feat:add-map
```

---

# Recommended Workflow

## 1. Pull Latest Development Branch

```bash
git checkout development
git pull origin development
```

---

## 2. Create New Branch

```bash
git checkout -b fuad/feat:add-map
```

---

## 3. Make Changes

Work only in your own branch.

---

## 4. Commit Changes

Use clear and meaningful commit messages.

### Common Commit Format

```txt
type(scope): short description
```

Examples:

```txt
feat(map): add Leaflet map component
fix(auth): resolve token validation error
docs(readme): update collaboration guide
```

---

# Common Commit Types

| Type | Description |
|---|---|
| feat | New feature |
| fix | Bug fix |
| docs | Documentation |
| style | UI/formatting only |
| refactor | Restructure code |
| test | Testing |
| chore | Maintenance |
| perf | Performance improvement |
| ci | CI/CD changes |

---

# Good Commit Message Examples

```bash
git commit -m "feat(map): add layer comparison tool"
```

```bash
git commit -m "fix(login): prevent session timeout"
```

```bash
git commit -m "docs(readme): add collaboration workflow"
```

---

# Bad Commit Examples

Avoid:

```txt
update
fix
final
done
hehe
```

---

# Best Practices

## Keep Commits Small

One commit = one logical change.

Good:

```txt
feat(chat): add typing indicator
```

Separate fix:

```txt
fix(chat): prevent duplicate messages
```

---

## Commit Frequently

Small commits are:
- easier to review
- easier to debug
- easier to revert

---

## Pull Before Push

Before pushing:

```bash
git pull origin development
```

Then:

```bash
git push origin fuad/feat:add-map
```

---

## Use Pull Requests

Never merge directly without review.

Workflow:

```txt
Feature Branch
    ↓
Pull Request
    ↓
Code Review
    ↓
Merge to development
```

---

# Merge Rules

## `development`
- Can contain ongoing development
- Must still be functional

## `main`
- Only stable releases
- Only merged from tested `development`

---

# Example Full Workflow

## Start Working

```bash
git checkout development
git pull origin development
git checkout -b fuad/feat:add-map
```

---

## Commit Changes

```bash
git add .
git commit -m "feat(map): add interactive map"
```

---

## Push Branch

```bash
git push origin fuad/feat:add-map
```

---

## Open Pull Request

```txt
fuad/feat:add-map → development
```

---

# Additional Best Practices

## Do Not Push Sensitive Files

Use `.gitignore`

Example:

```gitignore
.env
node_modules/
dist/
__pycache__/
```

---

## Review Code Before Merge

Checklist:
- No debug code
- No console logs
- No secrets/API keys
- Naming is consistent
- Code is readable

---

## Keep Pull Requests Small

Smaller PRs:
- easier to review
- easier to test
- easier to merge

---

# Collaboration Summary

```txt
1. Check current branch
2. Pull latest development
3. Create feature branch
4. Work on feature
5. Commit clearly
6. Push branch
7. Open Pull Request
8. Review
9. Merge to development
10. Release stable code to main
```