/* ============================================================
   ANIMATION MASTER TABLE
   SQL SERVER
   ============================================================ */

IF OBJECT_ID('dbo.Animations', 'U') IS NOT NULL
    DROP TABLE dbo.Animations;
GO

CREATE TABLE dbo.Animations
(
    Id UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT PK_Animations PRIMARY KEY
        DEFAULT NEWID(),

    Name NVARCHAR(100) NOT NULL,
    DisplayName NVARCHAR(150) NOT NULL,

    Type NVARCHAR(50) NOT NULL,

    CssClass NVARCHAR(200) NULL,

    Target NVARCHAR(100) NULL,

    DurationMs INT NOT NULL DEFAULT 500,

    DelayMs INT NOT NULL DEFAULT 0,

    Easing NVARCHAR(50) NOT NULL DEFAULT 'ease',

    RepeatCount NVARCHAR(30) NOT NULL DEFAULT '1',

    Direction NVARCHAR(30) NOT NULL DEFAULT 'normal',

    ConfigJson NVARCHAR(MAX) NULL,

    IsActive BIT NOT NULL DEFAULT 1,

    SortOrder INT NOT NULL DEFAULT 0,

    CreatedAt DATETIME2 NOT NULL
        DEFAULT SYSUTCDATETIME(),

    UpdatedAt DATETIME2 NULL
);
GO


/* ============================================================
   INSERT 60+ ANIMATIONS
   ============================================================ */

INSERT INTO dbo.Animations
(
    Name,
    DisplayName,
    Type,
    CssClass,
    Target,
    DurationMs,
    DelayMs,
    Easing,
    RepeatCount,
    Direction,
    ConfigJson,
    IsActive,
    SortOrder
)
VALUES

/* ================= LOADING ================= */

(
    'skeleton',
    'Skeleton Loader',
    'Loading',
    'skeleton-loader',
    'Card',
    1200, 0, 'ease-in-out', 'infinite', 'normal',
    '{"background":"#eeeeee","borderRadius":"12px"}',
    1, 1
),

(
    'shimmer',
    'Shimmer',
    'Loading',
    'shimmer-effect',
    'Card',
    1500, 0, 'linear', 'infinite', 'normal',
    '{"direction":"left-to-right"}',
    1, 2
),

(
    'loading-dots',
    'Loading Dots',
    'Loading',
    'loading-dots',
    'Loader',
    1200, 0, 'ease-in-out', 'infinite', 'normal',
    '{"dots":3}',
    1, 3
),

(
    'spinner',
    'Spinner',
    'Loading',
    'spinner-loader',
    'Loader',
    900, 0, 'linear', 'infinite', 'normal',
    '{"degrees":360}',
    1, 4
),

(
    'progress',
    'Progress Loading',
    'Loading',
    'progress-loader',
    'Loader',
    1800, 0, 'ease-in-out', 'infinite', 'normal',
    '{"progress":"0-100"}',
    1, 5
),

(
    'pulse-loader',
    'Pulse Loader',
    'Loading',
    'pulse-loader',
    'Loader',
    1000, 0, 'ease-in-out', 'infinite', 'normal',
    '{}',
    1, 6
),

(
    'wave-loader',
    'Wave Loader',
    'Loading',
    'wave-loader',
    'Loader',
    1200, 0, 'ease-in-out', 'infinite', 'normal',
    '{"bars":5}',
    1, 7
),

(
    'typing-loader',
    'Typing Loader',
    'Loading',
    'typing-loader',
    'Text',
    1200, 0, 'steps', 'infinite', 'normal',
    '{"dots":3}',
    1, 8
),


/* ================= FADE ================= */

(
    'fade-in',
    'Fade In',
    'Fade',
    'fade-in',
    'Element',
    500, 0, 'ease-out', '1', 'normal',
    '{}',
    1, 9
),

(
    'fade-out',
    'Fade Out',
    'Fade',
    'fade-out',
    'Element',
    500, 0, 'ease-in', '1', 'normal',
    '{}',
    1, 10
),

(
    'fade-up',
    'Fade Up',
    'Fade',
    'fade-up',
    'Element',
    600, 0, 'ease-out', '1', 'normal',
    '{"distance":"30px"}',
    1, 11
),

(
    'fade-down',
    'Fade Down',
    'Fade',
    'fade-down',
    'Element',
    600, 0, 'ease-out', '1', 'normal',
    '{"distance":"30px"}',
    1, 12
),

(
    'fade-left',
    'Fade Left',
    'Fade',
    'fade-left',
    'Element',
    600, 0, 'ease-out', '1', 'normal',
    '{"distance":"30px"}',
    1, 13
),

(
    'fade-right',
    'Fade Right',
    'Fade',
    'fade-right',
    'Element',
    600, 0, 'ease-out', '1', 'normal',
    '{"distance":"30px"}',
    1, 14
),


/* ================= SLIDE ================= */

(
    'slide-up',
    'Slide Up',
    'Slide',
    'slide-up',
    'Card',
    600, 0, 'ease-out', '1', 'normal',
    '{"distance":"40px"}',
    1, 15
),

(
    'slide-down',
    'Slide Down',
    'Slide',
    'slide-down',
    'Card',
    600, 0, 'ease-out', '1', 'normal',
    '{"distance":"40px"}',
    1, 16
),

(
    'slide-left',
    'Slide Left',
    'Slide',
    'slide-left',
    'Card',
    600, 0, 'ease-out', '1', 'normal',
    '{"distance":"40px"}',
    1, 17
),

(
    'slide-right',
    'Slide Right',
    'Slide',
    'slide-right',
    'Card',
    600, 0, 'ease-out', '1', 'normal',
    '{"distance":"40px"}',
    1, 18
),

(
    'slide-up-big',
    'Slide Up Big',
    'Slide',
    'slide-up-big',
    'Section',
    800, 0, 'cubic-bezier(0.22,1,0.36,1)', '1', 'normal',
    '{"distance":"100px"}',
    1, 19
),

(
    'slide-down-big',
    'Slide Down Big',
    'Slide',
    'slide-down-big',
    'Section',
    800, 0, 'cubic-bezier(0.22,1,0.36,1)', '1', 'normal',
    '{"distance":"100px"}',
    1, 20
),


/* ================= SCALE / ZOOM ================= */

(
    'scale-in',
    'Scale In',
    'Scale',
    'scale-in',
    'Card',
    500, 0, 'ease-out', '1', 'normal',
    '{"fromScale":"0.90","toScale":"1"}',
    1, 21
),

(
    'scale-out',
    'Scale Out',
    'Scale',
    'scale-out',
    'Card',
    500, 0, 'ease-in', '1', 'normal',
    '{"fromScale":"1","toScale":"0.90"}',
    1, 22
),

(
    'zoom-in',
    'Zoom In',
    'Zoom',
    'zoom-in',
    'Image',
    600, 0, 'ease-out', '1', 'normal',
    '{"fromScale":"0.80","toScale":"1"}',
    1, 23
),

(
    'zoom-out',
    'Zoom Out',
    'Zoom',
    'zoom-out',
    'Image',
    600, 0, 'ease-in', '1', 'normal',
    '{"fromScale":"1.10","toScale":"1"}',
    1, 24
),

(
    'zoom-hover',
    'Zoom Hover',
    'Zoom',
    'zoom-hover',
    'Image',
    350, 0, 'ease-out', '1', 'normal',
    '{"scale":"1.05"}',
    1, 25
),


/* ================= ROTATE ================= */

(
    'rotate',
    'Rotate',
    'Rotate',
    'rotate',
    'Icon',
    1000, 0, 'linear', 'infinite', 'normal',
    '{"degrees":360}',
    1, 26
),

(
    'rotate-in',
    'Rotate In',
    'Rotate',
    'rotate-in',
    'Element',
    700, 0, 'ease-out', '1', 'normal',
    '{"degrees":"-180"}',
    1, 27
),

(
    'rotate-out',
    'Rotate Out',
    'Rotate',
    'rotate-out',
    'Element',
    700, 0, 'ease-in', '1', 'normal',
    '{"degrees":"180"}',
    1, 28
),

(
    'spin-slow',
    'Slow Spin',
    'Rotate',
    'spin-slow',
    'Icon',
    2500, 0, 'linear', 'infinite', 'normal',
    '{"degrees":360}',
    1, 29
),


/* ================= BOUNCE ================= */

(
    'bounce',
    'Bounce',
    'Bounce',
    'bounce',
    'Element',
    1000, 0, 'ease', '1', 'normal',
    '{}',
    1, 30
),

(
    'bounce-in',
    'Bounce In',
    'Bounce',
    'bounce-in',
    'Card',
    900, 0, 'cubic-bezier(0.68,-0.55,0.27,1.55)', '1', 'normal',
    '{}',
    1, 31
),

(
    'bounce-hover',
    'Bounce Hover',
    'Bounce',
    'bounce-hover',
    'Button',
    450, 0, 'ease-out', '1', 'normal',
    '{"distance":"6px"}',
    1, 32
),


/* ================= FLIP ================= */

(
    'flip-x',
    'Flip X',
    'Flip',
    'flip-x',
    'Card',
    700, 0, 'ease-in-out', '1', 'normal',
    '{"degrees":180}',
    1, 33
),

(
    'flip-y',
    'Flip Y',
    'Flip',
    'flip-y',
    'Card',
    700, 0, 'ease-in-out', '1', 'normal',
    '{"degrees":180}',
    1, 34
),

(
    'flip-card',
    'Flip Card',
    'Flip',
    'flip-card',
    'Card',
    800, 0, 'ease-in-out', '1', 'normal',
    '{"perspective":"1000px"}',
    1, 35
),


/* ================= SHAKE / WOBBLE ================= */

(
    'shake',
    'Shake',
    'Motion',
    'shake',
    'Element',
    500, 0, 'ease-in-out', '1', 'normal',
    '{"distance":"5px"}',
    1, 36
),

(
    'shake-x',
    'Shake X',
    'Motion',
    'shake-x',
    'Element',
    500, 0, 'ease-in-out', '1', 'normal',
    '{"distance":"8px"}',
    1, 37
),

(
    'shake-y',
    'Shake Y',
    'Motion',
    'shake-y',
    'Element',
    500, 0, 'ease-in-out', '1', 'normal',
    '{"distance":"8px"}',
    1, 38
),

(
    'wobble',
    'Wobble',
    'Motion',
    'wobble',
    'Element',
    800, 0, 'ease-in-out', '1', 'normal',
    '{}',
    1, 39
),

(
    'swing',
    'Swing',
    'Motion',
    'swing',
    'Element',
    900, 0, 'ease-in-out', '1', 'normal',
    '{}',
    1, 40
),


/* ================= PULSE ================= */

(
    'pulse',
    'Pulse',
    'Pulse',
    'pulse',
    'Element',
    1000, 0, 'ease-in-out', 'infinite', 'normal',
    '{"scale":"1.03"}',
    1, 41
),

(
    'heartbeat',
    'Heartbeat',
    'Pulse',
    'heartbeat',
    'Icon',
    1200, 0, 'ease-in-out', 'infinite', 'normal',
    '{}',
    1, 42
),

(
    'soft-pulse',
    'Soft Pulse',
    'Pulse',
    'soft-pulse',
    'Card',
    1800, 0, 'ease-in-out', 'infinite', 'normal',
    '{"scale":"1.02"}',
    1, 43
),


/* ================= GLOW ================= */

(
    'glow',
    'Glow',
    'Glow',
    'glow',
    'Element',
    1500, 0, 'ease-in-out', 'infinite', 'alternate',
    '{"blur":"15px"}',
    1, 44
),

(
    'neon-glow',
    'Neon Glow',
    'Glow',
    'neon-glow',
    'Button',
    1800, 0, 'ease-in-out', 'infinite', 'alternate',
    '{"blur":"20px"}',
    1, 45
),

(
    'image-glow',
    'Image Glow',
    'Glow',
    'image-glow',
    'Image',
    1600, 0, 'ease-in-out', 'infinite', 'alternate',
    '{"blur":"12px"}',
    1, 46
),


/* ================= BLUR ================= */

(
    'blur-in',
    'Blur In',
    'Blur',
    'blur-in',
    'Element',
    700, 0, 'ease-out', '1', 'normal',
    '{"fromBlur":"10px"}',
    1, 47
),

(
    'blur-out',
    'Blur Out',
    'Blur',
    'blur-out',
    'Element',
    700, 0, 'ease-in', '1', 'normal',
    '{"toBlur":"10px"}',
    1, 48
),


/* ================= REVEAL ================= */

(
    'reveal-up',
    'Reveal Up',
    'Reveal',
    'reveal-up',
    'Section',
    800, 0, 'cubic-bezier(0.22,1,0.36,1)', '1', 'normal',
    '{"clip":"bottom"}',
    1, 49
),

(
    'reveal-left',
    'Reveal Left',
    'Reveal',
    'reveal-left',
    'Section',
    800, 0, 'cubic-bezier(0.22,1,0.36,1)', '1', 'normal',
    '{"clip":"left"}',
    1, 50
),

(
    'reveal-right',
    'Reveal Right',
    'Reveal',
    'reveal-right',
    'Section',
    800, 0, 'cubic-bezier(0.22,1,0.36,1)', '1', 'normal',
    '{"clip":"right"}',
    1, 51
),

(
    'reveal-circle',
    'Circle Reveal',
    'Reveal',
    'reveal-circle',
    'Image',
    900, 0, 'ease-out', '1', 'normal',
    '{"shape":"circle"}',
    1, 52
),


/* ================= HOVER ================= */

(
    'card-lift',
    'Card Lift',
    'Hover',
    'card-lift',
    'Card',
    300, 0, 'ease-out', '1', 'normal',
    '{"translateY":"-6px"}',
    1, 53
),

(
    'card-hover-scale',
    'Card Hover Scale',
    'Hover',
    'card-hover-scale',
    'Card',
    300, 0, 'ease-out', '1', 'normal',
    '{"scale":"1.03"}',
    1, 54
),

(
    'button-lift',
    'Button Lift',
    'Hover',
    'button-lift',
    'Button',
    250, 0, 'ease-out', '1', 'normal',
    '{"translateY":"-2px"}',
    1, 55
),

(
    'image-zoom',
    'Image Hover Zoom',
    'Hover',
    'image-zoom',
    'Image',
    500, 0, 'ease-out', '1', 'normal',
    '{"scale":"1.08"}',
    1, 56
),


/* ================= TEXT ================= */

(
    'text-reveal',
    'Text Reveal',
    'Text',
    'text-reveal',
    'Text',
    700, 0, 'ease-out', '1', 'normal',
    '{"direction":"up"}',
    1, 57
),

(
    'text-slide',
    'Text Slide',
    'Text',
    'text-slide',
    'Text',
    600, 0, 'ease-out', '1', 'normal',
    '{"distance":"30px"}',
    1, 58
),

(
    'typewriter',
    'Typewriter',
    'Text',
    'typewriter',
    'Text',
    3000, 0, 'steps', '1', 'normal',
    '{"characters":true}',
    1, 59
),


/* ================= STAGGER ================= */

(
    'stagger',
    'Stagger Cards',
    'Stagger',
    'stagger-animation',
    'Cards',
    600, 100, 'ease-out', '1', 'normal',
    '{"delayIncrement":"100ms"}',
    1, 60
),

(
    'stagger-fade',
    'Stagger Fade',
    'Stagger',
    'stagger-fade',
    'Cards',
    500, 100, 'ease-out', '1', 'normal',
    '{"delayIncrement":"80ms"}',
    1, 61
),


/* ================= SPECIAL ================= */

(
    'ripple',
    'Ripple',
    'Special',
    'ripple',
    'Button',
    600, 0, 'ease-out', '1', 'normal',
    '{"origin":"click"}',
    1, 62
),

(
    'gradient-flow',
    'Gradient Flow',
    'Special',
    'gradient-flow',
    'Background',
    3000, 0, 'linear', 'infinite', 'normal',
    '{"direction":"horizontal"}',
    1, 63
),

(
    'parallax',
    'Parallax',
    'Special',
    'parallax',
    'Section',
    1000, 0, 'linear', '1', 'normal',
    '{"strength":"20"}',
    1, 64
),

(
    'floating',
    'Floating',
    'Special',
    'floating',
    'Element',
    2500, 0, 'ease-in-out', 'infinite', 'alternate',
    '{"distance":"10px"}',
    1, 65
),

(
    'magnetic',
    'Magnetic Hover',
    'Special',
    'magnetic',
    'Button',
    400, 0, 'ease-out', '1', 'normal',
    '{"strength":"0.2"}',
    1, 66
),

(
    'border-flow',
    'Animated Border',
    'Special',
    'border-flow',
    'Card',
    2500, 0, 'linear', 'infinite', 'normal',
    '{}',
    1, 67
),

(
    'shine',
    'Shine Effect',
    'Special',
    'shine-effect',
    'Card',
    1800, 0, 'linear', 'infinite', 'normal',
    '{"angle":"45deg"}',
    1, 68
),

(
    'spotlight',
    'Spotlight',
    'Special',
    'spotlight-effect',
    'Card',
    800, 0, 'ease-out', '1', 'normal',
    '{"followMouse":true}',
    1, 69
),

(
    'image-reveal',
    'Image Reveal',
    'Special',
    'image-reveal',
    'Image',
    900, 0, 'ease-out', '1', 'normal',
    '{"direction":"left"}',
    1, 70
),

(
    'content-transition',
    'Content Transition',
    'Special',
    'content-transition',
    'Content',
    500, 0, 'ease-in-out', '1', 'normal',
    '{"mode":"replace"}',
    1, 71
);
GO


/* ============================================================
   VERIFY
   ============================================================ */

SELECT
    Id,
    Name,
    DisplayName,
    Type,
    CssClass,
    Target,
    DurationMs,
    DelayMs,
    Easing,
    RepeatCount,
    Direction,
    ConfigJson,
    IsActive,
    SortOrder
FROM dbo.Animations
ORDER BY SortOrder;
GO