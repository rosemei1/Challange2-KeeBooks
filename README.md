## 🧑‍💻 How to Contributes

### 1. Buat Branch Baru

```bash
git checkout -b feat/namafitur-anda
```

### 2. Commit Secara Bertahap

```bash
git add .
git commit -m "Deskripsi singkat"
```

### 3. Selalu Pull Dulu Sebelum Push

Supaya gak konflik:

```bash
git checkout main
git pull origin main
git checkout feat/namafitur-anda
git rebase main
```

Kalau ada konflik:

```bash
# resolve konfliknya dulu
git add .
git rebase --continue
```

### 4. Push Ke Remote

```bash
git push origin feat/namafitur-anda
```

### 5. Buat Pull Request

Masuk GitHub, buat PR dari branch kamu ke `main`.
