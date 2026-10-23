# Valorant Quick Setup

A one-click Windows batch script that sets up a shop PC for Valorant in seconds. Run it, play, and you're done. Since most shop PCs reset on reboot, there's nothing to undo.

## What it does

| Step | Change |
| --- | --- |
| 1 | Mouse pointer speed set to 6/11, Enhance Pointer Precision **off** |
| 2 | Power plan set to **High Performance** |
| 3 | Xbox Game Bar disabled |
| 4 | Fullscreen Optimizations disabled for VALORANT (if found) |
| 5 | Sticky Keys, Filter Keys and Toggle Keys popups disabled |
| 6 | Windows notification popups turned off |

When it finishes, it opens Display settings, shows a reminder of the stretched resolution steps, and launches VALORANT through the Riot Client if it can find it.

## How to use

1. Download `valorant_setup.bat`. On this page, click the file, then the **Download raw file** icon at the top right.
2. Double-click it. No admin rights are needed for the registry settings.
3. If Windows or your browser warns about the file, choose **Keep** or **Run anyway**.
4. If downloads are blocked, open the raw file, copy the text into Notepad, and save it as `valorant_setup.bat` (Save as type: **All Files**).

If the mouse or Sticky Keys settings seem unchanged, sign out and back in once.

## Stretched resolution (by hand)

True stretch can't be safely scripted, so the script only reminds you. Example: 1280x960.

**NVIDIA Control Panel**
1. Adjust desktop size and position: set scaling to **Full-screen** and untick **Override scaling mode**.
2. Change resolution > Customize > Create Custom Resolution: 1280x960.
3. In VALORANT: Display Mode **Windowed**, Resolution 1280x960, Aspect Ratio **Fill**.
4. Set the desktop to 1280x960 in NVIDIA Control Panel.

**AMD Radeon Software**
1. Settings > Display > Custom Resolutions > Create New: 1280x960. Check the refresh rate, then Save.
2. On the same Display page: GPU Scaling **On**, Scaling Mode **Full Panel**.
3. In VALORANT: Display Mode **Fullscreen**, your native resolution, Aspect Ratio **Fill**, Apply. Then switch to **Windowed** and Apply again.
4. In Windows Settings > Display, pick 1280x960 and keep the change.

Switch back to your native resolution before relaunching VALORANT, then repeat.

## Notes

- The script only changes current-user settings, a power plan and a compatibility flag. It doesn't touch antivirus, firewall, Vanguard or any game files.
- Your Valorant sensitivity, crosshair and keybinds are saved to your Riot account, so they load when you log in.
- Some shop PCs lock down settings, so a step may be skipped without an error.
- Not affiliated with or endorsed by Riot Games. Use at your own risk, and respect the shop's rules.
