{ inputs, ...}: {
    imports = [
        ./hardware-configuration.nix
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.initrd.luks.devices."luks-56c0d22d-aea7-4b07-9ee2-36b89c742aba".device = "/dev/disk/by-uuid/56c0d22d-aea7-4b07-9ee2-36b89c742aba";
    networking.hostName = "alexT";
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    networking.networkmanager.enable = true;
    networking.firewall.enable = false;

    time.timeZone = "Europe/Moscow";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "ru_RU.UTF-8";
        LC_IDENTIFICATION = "ru_RU.UTF-8";
        LC_MEASUREMENT = "ru_RU.UTF-8";
        LC_MONETARY = "ru_RU.UTF-8";
        LC_NAME = "ru_RU.UTF-8";
        LC_NUMERIC = "ru_RU.UTF-8";
        LC_PAPER = "ru_RU.UTF-8";
        LC_TELEPHONE = "ru_RU.UTF-8";
        LC_TIME = "ru_RU.UTF-8";
    };

    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
    };

    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };

    users.users.alex = {
        isNormalUser = true;
        description = "alex";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [ ];
    };

    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["alex"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config.allowUnfree = true;

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
        General = {
            Enable = "Source,Sink,Media,Socket";
            Experimental = true;
        };
        };
    };
    services.blueman.enable = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    environment.systemPackages = with pkgs; [
        atlauncher
        alacritty
        audacious
        audacity
        cheese
        ungoogled-chromium
        # cubicsdr
        drawio
        freecad
        geany
        telegram-desktop
        gparted
        gedit
        gimp
        # gnuradio
        # gqrx
        gscan2pdf
        inkscape
        libreoffice
        librewolf
        netbird
        obsidian
        kdePackages.okular
        orca-slicer
        plakativ
        rpi-imager
        # sdrpp
        speedcrunch
        syncthing
        steam
        thonny
        transmissions_4
        veracrypt
        virt-manager
        vscodium
        vlc

        btop
        pass
        tree
        wget
        git
        unzip
        scrot
        ffmpeg
        zip
        bluez
        bluez-tools

        home-manager
        spice-vdagent
    ];

    fonts.packages = with pkgs; [
        jetbrains-mono
        noto-fonts
        noto-fonts-emoji
        twemoji-color-font
        font-awesome
        powerline-fonts
        powerline-symbols
        (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];

    system.stateVersion = "25.11";
}