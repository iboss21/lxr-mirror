# 🐺 LXR-Mirror - Screenshots Guide

```
    ██╗     ██╗  ██╗██████╗       ███╗   ███╗██╗██████╗ ██████╗  ██████╗ ██████╗ 
    ██║     ╚██╗██╔╝██╔══██╗      ████╗ ████║██║██╔══██╗██╔══██╗██╔═══██╗██╔══██╗
    ██║      ╚███╔╝ ██████╔╝█████╗██╔████╔██║██║██████╔╝██████╔╝██║   ██║██████╔╝
    ██║      ██╔██╗ ██╔══██╗╚════╝██║╚██╔╝██║██║██╔══██╗██╔══██╗██║   ██║██╔══██╗
    ███████╗██╔╝ ██╗██║  ██║      ██║ ╚═╝ ██║██║██║  ██║██║  ██║╚██████╔╝██║  ██║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
```

**🐺 wolves.land | The Land of Wolves**

---

## 📖 Screenshots Overview

This document provides a comprehensive checklist for creating professional screenshots and promotional materials for the LXR-Mirror resource. Quality visual documentation is essential for showcasing the resource's features and capabilities.

---

## 📁 Storage Location

**Path:** `/docs/assets/screenshots/`

**Directory Structure:**
```
docs/
└── assets/
    └── screenshots/
        ├── 01_command_usage.png
        ├── 02_male_close_up.png
        ├── 03_female_close_up.png
        ├── 04_ui_overlay.png
        ├── 05_prop_in_hand.png
        ├── 06_animation_showcase.png
        ├── 07_camera_angle.png
        ├── 08_different_lighting.png
        ├── 09_character_preview.png
        ├── 10_config_screen.png
        ├── 11_framework_integration.png
        ├── 12_notification_example.png
        └── thumbnail.png
```

---

## ✅ Required Screenshots Checklist

### 1. Command Usage (01_command_usage.png)

**Purpose:** Show the `/mirror` command being used in-game

**Requirements:**
- [ ] Chat box visible with `/mirror` command typed
- [ ] Clear, readable text
- [ ] Before mirror activation (normal view)
- [ ] Character clearly visible
- [ ] HUD elements present

**Recommended Settings:**
- Resolution: 1920x1080 or higher
- Format: PNG
- Quality: Maximum
- Compression: Lossless

**What to Capture:**
```
Scene: Player standing in well-lit area
Action: Type /mirror in chat
Timing: Capture just after pressing Enter
View: Third-person, slightly angled
```

**Alternative:** Could show keybind being used with on-screen key display

---

### 2. Male Character Close-Up (02_male_close_up.png)

**Purpose:** Demonstrate mirror camera view with male character

**Requirements:**
- [ ] Mirror active (first-person camera view)
- [ ] Male character model
- [ ] Face clearly visible and centered
- [ ] Proper FOV (default: 10.0)
- [ ] UI overlay visible (mirror frame)
- [ ] Good lighting on face
- [ ] High detail textures

**Recommended Settings:**
- Camera FOV: 10.0 (Config.Camera.male.fov)
- Time of Day: 12:00 PM (noon) for best lighting
- Weather: Clear
- Location: Well-lit outdoor area

**What to Capture:**
```
Scene: Outdoor, daytime, clear weather
Character: Male with visible facial features
Mirror: Fully active with UI overlay
Focus: Face filling 70-80% of frame
Expression: Neutral or slight smile
```

**Post-Processing:**
- No filters
- Natural color balance
- Sharpen slightly if needed

---

### 3. Female Character Close-Up (03_female_close_up.png)

**Purpose:** Demonstrate mirror camera view with female character

**Requirements:**
- [ ] Mirror active (first-person camera view)
- [ ] Female character model
- [ ] Face clearly visible and centered
- [ ] Proper FOV (default: 20.0)
- [ ] UI overlay visible (mirror frame)
- [ ] Good lighting on face
- [ ] High detail textures

**Recommended Settings:**
- Camera FOV: 20.0 (Config.Camera.female.fov)
- Time of Day: 12:00 PM (noon)
- Weather: Clear
- Location: Well-lit outdoor area

**What to Capture:**
```
Scene: Outdoor, daytime, clear weather
Character: Female with visible facial features
Mirror: Fully active with UI overlay
Focus: Face filling 70-80% of frame
Expression: Neutral or slight smile
```

**Note:** Should demonstrate the different FOV compared to male character

---

### 4. UI Overlay Showcase (04_ui_overlay.png)

**Purpose:** Highlight the mirror frame UI overlay

**Requirements:**
- [ ] Mirror frame clearly visible
- [ ] High contrast against background
- [ ] Full UI frame in shot
- [ ] Character face centered within frame
- [ ] No HUD elements obscuring UI
- [ ] Sharp, clear image quality

**Recommended Settings:**
- UI enabled: Config.UI.enabled = true
- UI image: Default or custom frame
- Background: Neutral or slightly blurred

**What to Capture:**
```
Scene: Any location with good contrast
Focus: UI frame and its design
Character: Secondary to UI showcase
Highlight: Ornate frame details
Style: Artistic presentation
```

**Alternative Angles:**
- Close-up of frame corners/details
- Full frame with character
- Multiple frames (if custom ones available)

---

### 5. Prop in Hand (05_prop_in_hand.png)

**Purpose:** Show the pocket mirror prop attached to character's hand

**Requirements:**
- [ ] Mirror prop clearly visible
- [ ] Hand position realistic
- [ ] Prop model details visible
- [ ] Animation playing
- [ ] Good lighting on prop
- [ ] Third-person camera angle
- [ ] Prop model: p_pocketmirror01x

**Recommended Settings:**
- View: Third-person, angled view
- Distance: Medium (2-3 meters)
- Focus: Hand and prop
- Animation: Active

**What to Capture:**
```
Scene: Side or front view of character
Focus: Left hand holding mirror prop
Angle: Show prop details clearly
Lighting: Ensure prop is well-lit
Animation: Mid-animation pose
```

**Camera Angles:**
- Side view (90 degrees)
- Front-side angle (45 degrees)
- Close-up on hand and prop

---

### 6. Animation Showcase (06_animation_showcase.png)

**Purpose:** Display the character animation while using mirror

**Requirements:**
- [ ] Full character body visible
- [ ] Animation playing (not static)
- [ ] Prop attached and positioned correctly
- [ ] Natural pose
- [ ] Third-person view
- [ ] Clear environment

**Recommended Settings:**
- View: Full body shot
- Distance: 3-5 meters
- Angle: Slight front angle
- Animation: amb_misc@world_human_pocket_mirror@female_a@base

**What to Capture:**
```
Scene: Open area, minimal distractions
Character: Full body in frame
Animation: Active mirror animation
Pose: Natural standing position
Prop: Visible in hand
Background: Not too busy
```

---

### 7. Camera Angle Demo (07_camera_angle.png)

**Purpose:** Show the camera positioning and offset

**Requirements:**
- [ ] Split view or comparison shot
- [ ] Before and after camera activation
- [ ] Camera offset visible
- [ ] FOV difference clear
- [ ] Same character and location

**Recommended Settings:**
- Create comparison image
- Show normal view vs mirror view
- Same lighting and position

**What to Capture:**
```
Layout: Side-by-side comparison
Left: Normal third-person view
Right: Mirror first-person view
Character: Same pose/location
Labels: Optional (Before/After)
```

---

### 8. Different Lighting Conditions (08_different_lighting.png)

**Purpose:** Demonstrate mirror works in various lighting

**Requirements:**
- [ ] Multiple lighting scenarios
- [ ] Day and night examples
- [ ] Indoor and outdoor
- [ ] Different weather conditions
- [ ] Comparison layout

**Recommended Settings:**
- Create collage or grid
- 2-4 different scenarios
- Same character model

**What to Capture:**
```
Scenario 1: Bright daytime outdoor
Scenario 2: Indoor tavern/building
Scenario 3: Nighttime with lantern
Scenario 4: Overcast/rainy weather

Layout: 2x2 grid or horizontal strip
```

---

### 9. Character Preview/Customization (09_character_preview.png)

**Purpose:** Show mirror used for character preview

**Requirements:**
- [ ] Character creator or barber scenario
- [ ] Mirror used to preview changes
- [ ] Clear face visibility
- [ ] Contextual scene

**Recommended Settings:**
- Location: Barber shop or character creator
- Context: Preview after customization
- UI: Show customization UI if applicable

**What to Capture:**
```
Scene: Barber shop or creator screen
Use Case: Previewing new hairstyle/face
Mirror: Active showing results
Context: Clear purpose demonstration
```

---

### 10. Configuration Screen (10_config_screen.png)

**Purpose:** Show config.lua file structure

**Requirements:**
- [ ] Code editor screenshot
- [ ] config.lua open
- [ ] Important sections visible
- [ ] Syntax highlighting enabled
- [ ] Readable font size

**Recommended Tools:**
- VS Code
- Sublime Text
- Notepad++
- Atom

**What to Capture:**
```
File: config.lua
Sections: Show key configuration sections
Highlight: Important settings
Comments: Visible documentation
Theme: Dark theme preferred
Font: Readable size (14pt+)
```

---

### 11. Framework Integration (11_framework_integration.png)

**Purpose:** Show resource working with framework

**Requirements:**
- [ ] Framework resource visible
- [ ] LXR-Mirror resource running
- [ ] Console output showing detection
- [ ] Resource list or txAdmin view

**Recommended Views:**
- Server console with framework detection
- In-game resource list (F8 resmon)
- txAdmin resource panel
- Framework notification

**What to Capture:**
```
View: Console or resource manager
Output: Framework detection message
Resources: Both framework and mirror listed
Status: Both resources running
```

**Example Console Output:**
```
[LXR-Mirror] Detected framework: lxr-core
[LXR-Mirror] Framework adapter initialized: lxr-core
```

---

### 12. Notification Example (12_notification_example.png)

**Purpose:** Show notification system in action

**Requirements:**
- [ ] Notification visible on screen
- [ ] Clear, readable text
- [ ] Proper notification style
- [ ] Context visible

**Notification Types to Capture:**
- Mirror activated
- Mirror deactivated
- Cooldown message
- Error message (no item)

**What to Capture:**
```
Scene: In-game with notification displayed
Notification: Clear and readable
Type: Success/error/info
Text: Actual notification message
Style: Framework notification style
```

---

### 13. Thumbnail (thumbnail.png)

**Purpose:** Main promotional image for resource

**Requirements:**
- [ ] High quality (1920x1080 or higher)
- [ ] Eye-catching composition
- [ ] Shows mirror in action
- [ ] Professional looking
- [ ] Includes branding if desired

**Recommended Composition:**
- Character using mirror (close-up)
- UI overlay visible
- Wolves.land branding (optional)
- Resource name visible (optional)

**What to Capture:**
```
Style: Professional promotional shot
Subject: Character in mirror view
Quality: Maximum resolution
Composition: Centered, balanced
Lighting: Excellent
Post-Process: Color grade if needed
```

---

## 🎨 Screenshot Guidelines

### Technical Requirements

**Resolution:**
- Minimum: 1920x1080 (Full HD)
- Recommended: 2560x1440 (2K)
- Maximum: 3840x2160 (4K)

**Format:**
- Primary: PNG (lossless)
- Alternative: JPG (95%+ quality)
- Avoid: Heavily compressed formats

**File Size:**
- Target: < 5MB per screenshot
- Maximum: < 10MB per screenshot
- Use PNG compression tools if needed

### Visual Quality Standards

**Graphics Settings:**
- All settings: High or Ultra
- Anti-aliasing: Enabled (MSAA or FXAA)
- Texture quality: Maximum
- Shadow quality: High
- Reflection quality: High

**Lighting:**
- Use in-game time for best lighting
- Avoid extreme darkness
- Ensure face is well-lit
- Use natural light when possible

**Composition:**
- Rule of thirds
- Subject centered or offset artistically
- Clean background (minimal clutter)
- No UI elements unless required
- No watermarks (except optional branding)

### Post-Processing

**Allowed:**
- Color correction
- Brightness/contrast adjustment
- Sharpening (minimal)
- Cropping
- Resizing (downscaling only)
- Adding text/labels (if needed)

**Not Allowed:**
- Heavy filters
- Unrealistic edits
- Misleading modifications
- Fake features
- UI removal if it's a UI showcase

---

## 📸 Taking Screenshots

### In-Game Tools

**Method 1: F12 (Steam)**
- Default screenshot key
- Auto-saved to Steam folder
- High quality, uncompressed

**Method 2: Print Screen**
- Windows clipboard
- Paste into image editor
- Manual save required

**Method 3: ShareX / Lightshot**
- Third-party tools
- More control over capture
- Immediate editing

**Method 4: In-Game Photo Mode**
- If available in RedM
- Best for cinematic shots
- More camera control

### Recommended Tools

**Screenshot Capture:**
- ShareX (Windows)
- Lightshot (Cross-platform)
- Greenshot (Windows)
- Flameshot (Linux)

**Image Editing:**
- GIMP (Free)
- Paint.NET (Free)
- Photoshop (Paid)
- Affinity Photo (Paid)

**Image Optimization:**
- TinyPNG (Web)
- ImageOptim (Mac)
- FileOptimizer (Windows)

---

## 🎬 Video Capture (Optional)

### Short Demonstration Videos

**Recommended:**
- Duration: 15-30 seconds
- Format: MP4 (H.264)
- Resolution: 1920x1080
- Frame Rate: 60 FPS
- Bitrate: 10-20 Mbps

**Content Ideas:**

1. **Quick Demo** (15s)
   - Type command
   - Mirror opens
   - View character
   - Close mirror

2. **Feature Showcase** (30s)
   - Multiple camera angles
   - Different characters
   - UI overlay
   - Animation

3. **Comparison** (20s)
   - Male vs Female FOV
   - Different lighting
   - Various scenarios

**Hosting:**
- YouTube
- Streamable
- Imgur
- Direct download

---

## 📋 Checklist Summary

**Essential Screenshots (Must Have):**
- [x] Command usage demonstration
- [x] Male character close-up
- [x] Female character close-up
- [x] UI overlay showcase
- [x] Prop in hand view
- [x] Main thumbnail image

**Optional Screenshots (Nice to Have):**
- [ ] Animation showcase
- [ ] Camera angle comparison
- [ ] Different lighting conditions
- [ ] Character customization use
- [ ] Configuration file
- [ ] Framework integration
- [ ] Notification examples

**Promotional Materials:**
- [ ] Resource thumbnail (main image)
- [ ] Multiple preview images
- [ ] Short demonstration video
- [ ] GIF animations
- [ ] Feature comparison chart

---

## 🎯 Usage Scenarios

### For Documentation
Use screenshots in:
- README.md
- Installation guide
- Configuration guide
- Feature showcase

### For Promotion
Use screenshots on:
- GitHub repository
- Forum posts (CFX forum)
- Discord servers
- Tebex/Store listings
- Social media

### For Support
Use screenshots for:
- Bug reports
- Feature requests
- Tutorial creation
- Community support

---

## 📝 Screenshot Naming Convention

**Format:** `[number]_[description]_[optional_detail].png`

**Examples:**
```
01_command_usage.png
02_male_close_up.png
02_male_close_up_daytime.png
02_male_close_up_nighttime.png
03_female_close_up.png
04_ui_overlay_default_frame.png
04_ui_overlay_custom_frame.png
```

**Best Practices:**
- Use numbers for ordering
- Use underscores for spaces
- Be descriptive but concise
- Include variants if needed
- Keep names under 50 characters

---

## 🔍 Quality Control

### Before Publishing

**Check:**
- [ ] All required screenshots captured
- [ ] High resolution (1080p minimum)
- [ ] No personal information visible
- [ ] No copyrighted content
- [ ] Proper file names
- [ ] Optimized file sizes
- [ ] Organized in correct folder
- [ ] Clear and sharp images
- [ ] Good lighting and composition
- [ ] Professional appearance

### Review Checklist

**Technical:**
- ✅ Correct resolution
- ✅ Proper format (PNG/JPG)
- ✅ Acceptable file size
- ✅ No artifacts or compression issues

**Visual:**
- ✅ Well-lit and clear
- ✅ Subject visible and focused
- ✅ Good composition
- ✅ No visual glitches

**Content:**
- ✅ Shows intended feature
- ✅ Accurate representation
- ✅ Professional quality
- ✅ Matches documentation

---

## 💡 Pro Tips

### Lighting Tips
1. Use noon (12:00 PM) for outdoor shots
2. Avoid harsh shadows
3. Position character facing light source
4. Indoor: use well-lit areas
5. Night shots: use lanterns/fire nearby

### Composition Tips
1. Center subject or use rule of thirds
2. Minimize background distractions
3. Use depth of field if available
4. Frame subject properly
5. Leave some breathing room

### Technical Tips
1. Disable motion blur for screenshots
2. Max out all graphics settings
3. Use native resolution (no upscaling)
4. Capture in windowed mode for better control
5. Use screenshot tools, not phone camera

### Workflow Tips
1. Plan shots before taking them
2. Take multiple shots of same scene
3. Review screenshots immediately
4. Organize files as you go
5. Keep backup copies

---

## 📚 Related Documentation

- [Overview](overview.md)
- [Installation Guide](installation.md)
- [Configuration Reference](configuration.md)

---

## 📞 Support & Contribution

**Need Help with Screenshots?**
- Discord: https://discord.gg/CrKcWdfd3A
- GitHub: https://github.com/iBoss21

**Want to Contribute?**
Submit high-quality screenshots via:
- Pull request to GitHub
- Discord community
- Direct message to developer

---

**© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved**
