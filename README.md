# Naveen Singh — Portfolio

Personal portfolio site for **Naveen Singh**, Full Stack Developer & Team Lead. A recruiter-focused single-page site showcasing experience, skills, selected production work, and LinkedIn contact.

**Live site:** enable [GitHub Pages](#deploy-on-github-pages) after pushing to GitHub.

## Stack

- **HTML** — one page (`index.html`)
- **Tailwind CSS** (CDN) — layout and theme
- **Vanilla JavaScript** — typing hero, scroll reveals, project sliders, mobile nav, back to top
- **Geist** & **JetBrains Mono** (Google Fonts)
- **Material Symbols** — icons

## Site sections

| Section | Description |
|--------|-------------|
| Hero | Profile photo, headline, typing animation, CTAs |
| Stats | Experience, projects delivered, team leadership |
| About & Experience | Bio, photo, work timeline |
| Skills | Frontend, backend, data, cloud, delivery |
| Projects | Selected production case studies with image sliders |
| How I Work | 3-step approach (Listen → Architect → Ship) |
| Contact | Email, phone, CV download, LinkedIn |

## Project structure

```
├── index.html
├── public/images/          # Profile + project screenshots
├── public/CNAME            # Custom domain (root asset paths on build)
├── public/Naveen-Singh-CV.pdf  # CV (copied to site root on build)
├── Naveen-Singh-CV.pdf     # Symlink for local PHP dev (optional)
├── scripts/build-pages.sh  # Production build (GitHub Pages)
├── .github/workflows/      # Auto-deploy on push
├── images -> public/images # Symlink (optional, for PHP dev)
└── dist/                   # Build output (gitignored)
```

## Run locally

### PHP

```bash
php -S localhost:3001
```

Open [http://localhost:3001](http://localhost:3001). Uses the `images` symlink if present.

### Vite

```bash
npm install
npm run dev
```

### Production build (same as GitHub Pages)

```bash
npm run build
npm run preview
```

Opens `dist/` at [http://localhost:4173](http://localhost:4173).

## Profile photo

`public/images/profile/naveensingh.png` — portrait or square, at least 800px wide.

## Deploy on GitHub Pages

### 1. Push to GitHub

```bash
git init
git add .
git commit -m "Portfolio site"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```

### 2. Enable Pages

1. Open the repo on GitHub → **Settings** → **Pages**
2. Under **Build and deployment**, set **Source** to **GitHub Actions**
3. Push to `main` (or run the **Deploy to GitHub Pages** workflow manually)

The workflow (`.github/workflows/deploy.yml`) builds `dist/` with `index.html` + `images/` and deploys it.

### 3. Your URL

| Repo type | URL |
|-----------|-----|
| `YOUR_USERNAME.github.io` | `https://YOUR_USERNAME.github.io/` |
| Any other repo (e.g. `portfolio`) | `https://YOUR_USERNAME.github.io/portfolio/` |

The build rewrites image paths for your repo name (e.g. `/linkedin-portfolio/images/...`). If `public/CNAME` is present (custom domain), paths use the site root (`/images/...`) so assets work at `https://naveensingh.codes/`.

**Local preview matching GitHub:**

```bash
# Custom domain (this repo)
npm run build && npm run preview

# github.io project URL without a custom domain
GITHUB_REPOSITORY=codewithnaveen7/YOUR_REPO_NAME npm run build
npm run preview
```

## Links

- [LinkedIn](https://www.linkedin.com/in/developernaveen7/)
- Email: mynameisnaveensingh@gmail.com
- Phone: +91 77103 68332

Update `public/Naveen-Singh-CV.pdf` when your CV changes, then redeploy.
