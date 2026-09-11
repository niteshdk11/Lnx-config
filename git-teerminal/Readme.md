
# 🚀 GitHub Repo Clone with FZF + SSH Setup (Linux/macOS)

This guide sets up a fuzzy search GitHub clone tool using the GitHub CLI (`gh`), `fzf`, and SSH authentication.

---

## 🔧 Dependencies (Install via [Homebrew](https://brew.sh))

```bash
brew install gh fzf jq git
````

> ❗ You must also be logged in to GitHub with `gh`:

```bash
gh auth login
```

---

## 📦 GitHub Clone Function with FZF

Add the following function to your `~/.zshrc` or `~/.bashrc`:

```bash
# GitHub Clone Function with FZF
ghc() {
  echo "📦 Fetching your GitHub repositories..."

  local selected
  selected=$(gh repo list --limit 1000 --json name,description,sshUrl,visibility,updatedAt \
    --template '{{range .}}{{.name}}{{"\t"}}{{.description}}{{"\t"}}{{.visibility}}{{"\t"}}{{.updatedAt}}{{"\t"}}{{.sshUrl}}{{"\n"}}{{end}}' \
    | fzf --ansi --delimiter='\t' \
          --with-nth=1,2,3 \
          --preview='echo -e "\033[1;32mName:\033[0m {1}\n\033[1;33mDesc:\033[0m {2}\n\033[1;36mVisibility:\033[0m {3}\n\033[1;35mUpdated:\033[0m {4}"' \
          --preview-window=right:60%:wrap \
          --header="🔍 FZF: Search and clone GitHub repo" \
          --prompt="Select repo: " \
          --height=40% --border)

  [[ -z "$selected" ]] && echo "❌ No repo selected." && return

  local url
  url=$(awk -F '\t' '{print $5}' <<< "$selected")

  echo "⬇️  Cloning: $url ..."
  git clone "$url"
}

```

Reload your shell:

```bash
source ~/.zshrc  # or source ~/.bashrc
```

Now run:

```bash
ghc
```

---

## 🔐 SSH Setup for GitHub (one-time)

### 1. Generate SSH key

```bash
ssh-keygen -t ed25519 -C "youremail@example.com"
```

Press `Enter` to accept default path: `~/.ssh/id_ed25519`

---

### 2. Start SSH Agent

```bash
eval "$(ssh-agent -s)"
```

---

### 3. Add private key to agent

```bash
ssh-add ~/.ssh/id_ed25519
```

---

### 4. Add public key to GitHub

Copy your public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Then go to [GitHub → Settings → SSH and GPG keys](https://github.com/settings/keys) → **New SSH Key** → Paste and save.

---

### 5. Test SSH Connection

```bash
ssh -T git@github.com
```

Expected Output:

```bash
Hi your-username! You've successfully authenticated...
```

---

## 🔁 After Reboot (every time unless automated)

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

---

## 🧠 Optional: Automate SSH Add on Terminal Start

Add this to your `~/.zshrc` or `~/.bashrc`:

```bash
eval "$(ssh-agent -s)" > /dev/null
ssh-add ~/.ssh/id_ed25519 2>/dev/null
```

Then reload:

```bash
source ~/.zshrc
```

---
