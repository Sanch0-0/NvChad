# My NvChad Configuration

This repository contains my personal configuration for [NvChad](https://nvchad.com), including custom plugins, keymaps, LSP settings, and formatting/linting tools for Python development.  

---

## Prerequisites

1. **Neovim**  
   Make sure you have the **latest stable Neovim** installed:  
   [Neovim releases](https://github.com/neovim/neovim/releases/tag/stable)  

   Example installation via `.tar.gz`:

   ```bash
   # Download the tar.gz
   wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
   # Extract it
   tar xzf nvim-linux64.tar.gz
   # Move to /usr/local (or your preferred location)
   sudo mv nvim-linux64 /usr/local/nvim
   # Add to PATH
   export PATH=/usr/local/nvim/bin:$PATH
   # Check version
   nvim --version
   
2. **NvChad**  
   Install NvChad in ~/.config/nvim:
   [NvChad installation](https://nvchad.com/docs/quickstart/install/)

4. **Installing My Configuration**  
- After NvChad is installed, clone my configuration into ~/.config/nvim:
  ```bash
  rm -rf ~/.config/nvim
  git clone git.github.com/Sanch0-0/NvChad.git
  ```
- Open Neovim and run Lazy sync to install all plugins:
  ```bash
  :Lazy sync
  ```
**NOTES**  
Remove any leftover .git folder from ~/.config/nvim to prevent nested repositories:
```bash
rm -rf ~/.config/nvim/.git
```
   
