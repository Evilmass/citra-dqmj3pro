# citra-dqmj3pro

Custom-built emulator optimized for Monster Hunter Double Cross
- **Fix lag:** Periodic slowdowns with frame drops
- **Port functions:** Touch-mapping, fix SaveStates hotkeys

Inspired by
- [Lurpigi/Lime3DS](https://github.com/Lurpigi/lime3ds-dqmj3p)
- [Slashaim/citra-dqmj3pro](https://github.com/Slashaim/citra-dqmj3pro)

**Warning**
- Do not cherry-pick this commit: [Update FPS to roughly match the actual 3DS rate](https://github.com/Evilmass/citra-nightly/commit/5e95b35900bb8c840169c4446634ff67982aa842), It will cause the frame rate to randomly drop to 56.
- also keep `src\core\hw\gpu.h -> SCREEN_REFRESH_RATE = 60`


## buildtools
- **[VS2022_BuildTools](https://aka.ms/vs/17/release/vs_buildtools.exe)**
- **[Vulkan SDK 1.4.304.1](https://sdk.lunarg.com/sdk/download/1.4.304.1/windows/VulkanSDK-1.4.304.1-Installer.exe)**
- **[Cmake](https://github.com/Kitware/CMake/releases/download/v4.0.3/cmake-4.0.3-windows-x86_64.msi)**
- **[Git](https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/Git-2.50.1-64-bit.exe)**
- **[7z](https://www.7-zip.org/a/7z2500-x64.exe)**

```shell
# vulkan SDK
VulkanSDK-1.4.304.1-Installer.exe --accept-licenses --default-answer --confirm-command install --system-proxy=http://127.0.0.1:10808
```

## build

```shell
git clone --recursive https://github.com/Evilmass/citra-dqmj3pro
mkdir build && cd build

# msvc 2019
cmake .. -G "Visual Studio 17 2022" -A x64 -T v142 -DCMAKE_SYSTEM_VERSION=10.0.19041.0 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DENABLE_QT_TRANSLATION=ON -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF -DUSE_DISCORD_PRESENCE=OFF
cd ..
msbuild build/citra.sln -m -p:Configuration=Release,Platform=x64 -t:Rebuild

# pack
bash pack.sh build/
```

## note
```shell
# aqtinstall
aqt.exe install-qt windows desktop 6.5.0 win64_msvc2019_64 -m qtmultimedia --outputdir ./qt-6.5.0-msvc2019_64 # qttranslations
```

## Original Fork Description

This fork is based off nightly-1962 (commit `aaeba6759e6d57968ce0b12f6245f45836dec546`). The only change it makes is reverting the core timing rewrite in nightly-1544, which caused a performance drop in Dragon Quest Monsters Joker 3 Professional (https://citra-emu.org/wiki/citra-legacy-builds/#last-build-before-the-core-timing-rewrite). It will likely cause performance regressions for almost every other game.

It is helpful if for some reason you cannot run nightly-1543 (for example, if you use an AMD GPU that no longer uses drivers that work with nightly-1543).

### Significant Nightly Releases
https://github.com/citra-emu/citra-nightly/releases/tag/nightly-1543

https://github.com/citra-emu/citra-nightly/releases/tag/nightly-1544

https://github.com/citra-emu/citra-nightly/releases/tag/nightly-1962


## Original README

<h1 align="center">
  <br>
  <a href="https://citra-emu.org/"><img src="https://raw.githubusercontent.com/citra-emu/citra-assets/master/Main/citra_logo.svg" alt="Citra" width="200"></a>
  <br>
  <b>Citra</b>
  <br>
</h1>

<h4 align="center"><b>Citra</b> is the world's most popular, open-source, Nintendo 3DS emulator.
<br>
It is written in C++ with portability in mind and builds are actively maintained for Windows, Linux, Android and macOS.
</h4>

<p align="center">
    <a href="https://github.com/citra-emu/citra/actions/">
        <img src="https://github.com/citra-emu/citra/workflows/citra-ci/badge.svg"
            alt="GitHub Actions Build Status">
    </a>
    <a href="https://discord.gg/FAXfZV9">
        <img src="https://img.shields.io/discord/220740965957107713?color=%237289DA&label=Citra&logo=discord&logoColor=white"
            alt="Discord">
    </a>
</p>

<p align="center">
  <a href="#compatibility">Compatibility</a> |
  <a href="#releases">Releases</a> |
  <a href="#development">Development</a> |
  <a href="#building">Building</a> |
  <a href="#support">Support</a> |
  <a href="#license">License</a>
</p>


## Compatibility

The emulator is capable of running most commercial games at full speed, provided you meet the necessary hardware requirements.

For a full list of games Citra supports, please visit our [Compatibility page](https://citra-emu.org/game/)

Check out our [website](https://citra-emu.org/) for the latest news on exciting features, progress reports, and more!
Please read the [FAQ](https://citra-emu.org/wiki/faq/) before getting started with the project.

Need help? Check out our [asking for help](https://citra-emu.org/help/reference/asking/) guide.

## Releases

Citra has two main release channels: Nightly and Canary.

The [Nightly](https://github.com/citra-emu/citra-nightly) build is based on the master branch, and contains already reviewed and tested features.

The [Canary](https://github.com/citra-emu/citra-canary) build is based on the master branch, but with additional features still under review. PRs tagged `canary-merge` are merged only into the Canary builds.

Both builds can be installed with the installer provided on the [website](https://citra-emu.org/download/), but those looking for specific versions or standalone releases can find them in the release tabs of the [Nightly](https://github.com/citra-emu/citra-nightly/releases) and [Canary](https://github.com/citra-emu/citra-canary/releases) repositories.

Android builds can be downloaded from the Google Play Store.

A Flatpak for Citra is available on [Flathub](https://flathub.org/apps/details/org.citra_emu.citra). Details on the build process can be found in [our Flathub repository](https://github.com/flathub/org.citra_emu.citra).

## Development

Most of the development happens on GitHub. It's also where [our central repository](https://github.com/citra-emu/citra) is hosted.
For development discussion, please join us on our [Discord server](https://citra-emu.org/discord/) or at #citra-dev on libera.

If you want to contribute please take a look at the [Contributor's Guide](https://github.com/citra-emu/citra/wiki/Contributing) and [Developer Information](https://github.com/citra-emu/citra/wiki/Developer-Information). You can also contact any of the developers on Discord in order to know about the current state of the emulator.

If you want to contribute to the user interface translation, please check out the [Citra project on transifex](https://www.transifex.com/citra/citra). We centralize the translation work there, and periodically upstream translations.

## Building

* __Windows__: [Windows Build](https://github.com/citra-emu/citra/wiki/Building-For-Windows)
* __Linux__: [Linux Build](https://github.com/citra-emu/citra/wiki/Building-For-Linux)
* __macOS__: [macOS Build](https://github.com/citra-emu/citra/wiki/Building-for-macOS)
* __Android__: [Android Build](https://github.com/citra-emu/citra/wiki/Building-for-Android)


## Support

If you enjoy the project and want to support us financially, check out our Patreon!

<a href="https://www.patreon.com/citraemu">
    <img src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" width="160">
</a>

We also happily accept donated games and hardware.
Please see our [donations page](https://citra-emu.org/donate/) for more information on how you can contribute to Citra.
Any donations received will go towards things like:
* 3DS consoles for developers to explore the hardware
* 3DS games for testing
* Any equipment required for homebrew
* Infrastructure setup

We also more than gladly accept used 3DS consoles! If you would like to give yours away, don't hesitate to join our [Discord server](https://citra-emu.org/discord/) and talk to bunnei.


## License

Citra is licensed under the GPLv2 (or any later version). Refer to the [LICENSE.txt](https://github.com/citra-emu/citra/blob/master/license.txt) file.
