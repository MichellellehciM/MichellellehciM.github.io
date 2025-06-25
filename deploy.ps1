param (
    [string]$message = "更新網站"
)

Write-Host "🚀 Hugo 部署開始..."

# Step 1: 切回 main 並提交原始碼
cd "C:\ASTRO_CAMP_related\personal_blog\MichellellehciM.github.io"
git checkout main
git pull origin main
git add .
git commit -m "deploy: $message (main)"
git push origin main

# Step 2: 建立靜態網站
hugo -D

# Step 3: 進入 public（gh-pages worktree）並部署
cd public
git add .
git commit -m "deploy: $message (gh-pages)"
git push -f origin gh-pages

Write-Host " 部署完成請查看:https://michellellehcim.github.io/"


# .\deploy.ps1 "輸入內容"