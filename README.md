# ❄️ nix-config (AI-generated readme)

> A modular, multi-user, multi-host Nix and Home Manager setup

## ✨ Features

* 🧩 **Flake-based** declarative configuration
* 👥 **Multi-user** support (e.g., `hank`, `fendada`, `linwhite`, etc.)
* 🖥️ **Multi-host** setup: `b660`, `tank`, `7540u`, `rpi4`, `hackintosh`, `m3max`, `wsl`, and more
* 🏠 **Home Manager** for Linux and macOS (`darwin`)
* ⚙️ **Modular architecture** under `modules/` for easy reuse
* 🌈 Custom theming with `Catppuccin`, wallpapers, and `Neofetch` art
* 🖱️ Wayland-ready desktop environment: `Hyprland`, `Waybar`, `Tofi`, `fcitx5`
* 💻 Dev-friendly tools: `Vim`, `Helix`, `Kitty`, `Ghostty`, `Starship`
* 🔧 Power-user utilities: `vfio`, `virtualisation`, `grub`, keyboard remapping via `keyd`

## 📁 Structure Overview

```text
.
├── flake.nix                # Flake entry point
├── flake.lock               # Locked dependencies
├── Justfile                 # Command shortcuts (build/run tasks)
├── lib/                     # mkConfigurations, mkHomeConfigurations
├── modules/                 # Reusable Nix + Home Manager modules
├── hosts/                   # Per-host NixOS configs (hardware + system)
├── home/                    # Per-user Home Manager configs (base/linux/darwin)
├── wallpapers/              # Custom wallpapers
└── fonts/                   # Custom font files (e.g., Recursive)
```

## 🚀 Usage

Clone the repo and activate a host or user config with flakes:

```bash
git clone https://github.com/your-username/nix-config
cd nix-config
```

### 🧑‍💻 For system (NixOS):

```bash
sudo nixos-rebuild switch --flake .#tank
```

### 🏠 For Home Manager:

```bash
home-manager switch --flake .#hank@linux
```

*Replace `tank` or `hank@linux` with your actual host/user target.*

## 📸 Screenshots

*Add screenshots of your setup (Waybar, Neofetch, Hyprland, etc.) here*

## 📄 License

MIT
