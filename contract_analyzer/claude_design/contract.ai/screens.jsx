// screens.jsx — all screens for contract.ai mobile MVP
// Each screen takes (props) including go(screenName) for navigation.

// ── Brand tokens (overridable via Tweaks) ───────────────────────────────
const defaultTokens = {
  accent: '#d97757',          // terracotta
  accentDeep: '#b85a3e',
  accentSoft: '#fbe9df',
  bg: '#faf7f2',              // cream
  card: '#ffffff',
  ink: '#1f1a16',
  ink2: '#4a4039',
  muted: '#8a807a',
  hair: '#ece6dd',
  red: '#dc2626', redSoft: '#fdecec', redInk: '#7f1d1d',
  amber: '#d97706', amberSoft: '#fdf3df', amberInk: '#78350f',
  blue: '#3b82f6', blueSoft: '#e8efff', blueInk: '#1e3a8a',
  green: '#0dac81',
};

const dark = {
  accent: '#e89373', accentDeep: '#d97757', accentSoft: '#3a221a',
  bg: '#161311', card: '#211c19', ink: '#f5efe8', ink2: '#cfc6bc', muted: '#8a807a',
  hair: '#2c2521',
  red: '#f87171', redSoft: '#3a1a1a', redInk: '#fca5a5',
  amber: '#fbbf24', amberSoft: '#3a2810', amberInk: '#fcd34d',
  blue: '#60a5fa', blueSoft: '#1a2640', blueInk: '#bfdbfe',
  green: '#13be90',
};

function tokensFor(t) {
  const base = t.dark ? dark : defaultTokens;
  return { ...base, accent: t.accent || base.accent };
}

// ── Tiny icon set (SVG) ─────────────────────────────────────────────────
const Icon = {
  // brand mark — three lines with a dot on the middle one (flagged clause)
  logo: (c, size = 40) => (
    <svg width={size} height={size} viewBox="0 0 40 40" fill="none">
      <rect x="6"  y="11" width="20" height="3" rx="1.5" fill={c} opacity="0.35"/>
      <rect x="6"  y="18.5" width="28" height="3" rx="1.5" fill={c}/>
      <rect x="6"  y="26" width="16" height="3" rx="1.5" fill={c} opacity="0.35"/>
      <circle cx="34" cy="20" r="3.5" fill={c}/>
    </svg>
  ),
  doc: (c, s = 22) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><path d="M6 3h8l4 4v14a1 1 0 01-1 1H6a1 1 0 01-1-1V4a1 1 0 011-1z" stroke={c} strokeWidth="1.6"/><path d="M14 3v4h4" stroke={c} strokeWidth="1.6"/></svg>,
  upload: (c, s = 22) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><path d="M12 16V5m0 0l-4 4m4-4l4 4" stroke={c} strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"/><path d="M5 17v2a2 2 0 002 2h10a2 2 0 002-2v-2" stroke={c} strokeWidth="1.8" strokeLinecap="round"/></svg>,
  camera: (c, s = 22) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><rect x="3" y="7" width="18" height="13" rx="2" stroke={c} strokeWidth="1.6"/><circle cx="12" cy="13.5" r="3.5" stroke={c} strokeWidth="1.6"/><path d="M8 7l1.5-2h5L16 7" stroke={c} strokeWidth="1.6"/></svg>,
  text: (c, s = 22) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><path d="M5 6h14M5 12h14M5 18h9" stroke={c} strokeWidth="1.8" strokeLinecap="round"/></svg>,
  cloud: (c, s = 22) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><path d="M7 18a4 4 0 010-8 6 6 0 0111.5 1.5A3.5 3.5 0 0117 18H7z" stroke={c} strokeWidth="1.6"/></svg>,
  search: (c, s = 18) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><circle cx="11" cy="11" r="6.5" stroke={c} strokeWidth="1.8"/><path d="M16 16l4 4" stroke={c} strokeWidth="1.8" strokeLinecap="round"/></svg>,
  home: (c, s = 22) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><path d="M4 11l8-7 8 7v8a2 2 0 01-2 2h-3v-6h-6v6H6a2 2 0 01-2-2v-8z" stroke={c} strokeWidth="1.6" strokeLinejoin="round"/></svg>,
  history: (c, s = 22) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><path d="M4 12a8 8 0 108-8" stroke={c} strokeWidth="1.6" strokeLinecap="round"/><path d="M4 4v5h5" stroke={c} strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round"/><path d="M12 8v5l3 2" stroke={c} strokeWidth="1.6" strokeLinecap="round"/></svg>,
  user: (c, s = 22) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><circle cx="12" cy="9" r="3.5" stroke={c} strokeWidth="1.6"/><path d="M5 20c1-3.5 4-5 7-5s6 1.5 7 5" stroke={c} strokeWidth="1.6" strokeLinecap="round"/></svg>,
  back: (c, s = 22) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><path d="M14 6l-6 6 6 6" stroke={c} strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/></svg>,
  chevR: (c, s = 18) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><path d="M9 6l6 6-6 6" stroke={c} strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/></svg>,
  close: (c, s = 22) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><path d="M6 6l12 12M18 6L6 18" stroke={c} strokeWidth="2" strokeLinecap="round"/></svg>,
  more: (c, s = 22) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><circle cx="5" cy="12" r="1.6" fill={c}/><circle cx="12" cy="12" r="1.6" fill={c}/><circle cx="19" cy="12" r="1.6" fill={c}/></svg>,
  share: (c, s = 20) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><path d="M12 4v12m0-12l-4 4m4-4l4 4" stroke={c} strokeWidth="1.7" strokeLinecap="round" strokeLinejoin="round"/><path d="M5 14v4a2 2 0 002 2h10a2 2 0 002-2v-4" stroke={c} strokeWidth="1.7" strokeLinecap="round"/></svg>,
  check: (c, s = 18) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><path d="M5 12l5 5L20 7" stroke={c} strokeWidth="2.2" strokeLinecap="round" strokeLinejoin="round"/></svg>,
  flag: (c, s = 16) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><path d="M5 21V4h11l-2 4 2 4H5" stroke={c} strokeWidth="1.8" strokeLinejoin="round"/></svg>,
  eye: (c, s = 16) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><path d="M2 12s4-7 10-7 10 7 10 7-4 7-10 7S2 12 2 12z" stroke={c} strokeWidth="1.6"/><circle cx="12" cy="12" r="3" stroke={c} strokeWidth="1.6"/></svg>,
  info: (c, s = 16) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><circle cx="12" cy="12" r="9" stroke={c} strokeWidth="1.6"/><path d="M12 11v6M12 7.5v.5" stroke={c} strokeWidth="1.8" strokeLinecap="round"/></svg>,
  sparkle: (c, s = 18) => <svg width={s} height={s} viewBox="0 0 24 24" fill="none"><path d="M12 3l1.8 5.2L19 10l-5.2 1.8L12 17l-1.8-5.2L5 10l5.2-1.8L12 3z" fill={c}/></svg>,
};

// ── Severity helpers ────────────────────────────────────────────────────
const SEV = {
  red:   { label: 'Red flag', short: 'Red',  icon: Icon.flag },
  amber: { label: 'Watch-out', short: 'Watch', icon: Icon.eye },
  blue:  { label: 'FYI', short: 'FYI', icon: Icon.info },
};
function sevColor(t, k) {
  if (k === 'red')   return { fg: t.red,   bg: t.redSoft,   ink: t.redInk };
  if (k === 'amber') return { fg: t.amber, bg: t.amberSoft, ink: t.amberInk };
  return { fg: t.blue, bg: t.blueSoft, ink: t.blueInk };
}

// Severity chip — variant 'soft' (default) or 'solid'
function SevChip({ kind, t, style = 'soft', size = 'md' }) {
  const c = sevColor(t, kind);
  const I = SEV[kind].icon;
  const sm = size === 'sm';
  if (style === 'solid') {
    return (
      <span style={{
        display: 'inline-flex', alignItems: 'center', gap: 5,
        padding: sm ? '3px 8px' : '5px 10px',
        borderRadius: 999, background: c.fg, color: '#fff',
        fontSize: sm ? 11 : 12, fontWeight: 600, letterSpacing: 0.1,
      }}>
        {I('#fff', sm ? 11 : 13)} {SEV[kind].label}
      </span>
    );
  }
  return (
    <span style={{
      display: 'inline-flex', alignItems: 'center', gap: 5,
      padding: sm ? '3px 8px' : '5px 10px',
      borderRadius: 999, background: c.bg, color: c.ink,
      fontSize: sm ? 11 : 12, fontWeight: 600,
    }}>
      {I(c.fg, sm ? 11 : 13)} {SEV[kind].label}
    </span>
  );
}

// Severity dot (compact indicator)
function SevDot({ kind, t, size = 8 }) {
  return <span style={{ display: 'inline-block', width: size, height: size, borderRadius: 999, background: sevColor(t, kind).fg }} />;
}

// ── Common screen shell ─────────────────────────────────────────────────
function ScreenShell({ children, t, padTop = 54 }) {
  return (
    <div style={{
      width: '100%', minHeight: '100%', background: t.bg, color: t.ink,
      paddingTop: padTop, fontFamily: 'ploni, -apple-system, system-ui, sans-serif',
    }}>{children}</div>
  );
}

// ── Tab bar (used on Home / History / Settings) ─────────────────────────
function TabBar({ active, go, t }) {
  const tabs = [
    { k: 'home',     label: 'Home',     icon: Icon.home },
    { k: 'history',  label: 'History',  icon: Icon.history },
    { k: 'settings', label: 'You',      icon: Icon.user },
  ];
  return (
    <div style={{
      position: 'absolute', left: 0, right: 0, bottom: 0,
      paddingBottom: 28, paddingTop: 10, paddingInline: 24,
      background: t.card + 'f5', backdropFilter: 'blur(20px)',
      borderTop: `1px solid ${t.hair}`,
      display: 'flex', justifyContent: 'space-around', zIndex: 5,
    }}>
      {tabs.map(tab => {
        const on = tab.k === active;
        return (
          <button key={tab.k} onClick={() => go(tab.k)} style={{
            background: 'transparent', border: 0, padding: '6px 14px',
            display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 3,
            color: on ? t.accent : t.muted, cursor: 'pointer',
          }}>
            {tab.icon(on ? t.accent : t.muted, 24)}
            <span style={{ fontSize: 11, fontWeight: on ? 600 : 500 }}>{tab.label}</span>
          </button>
        );
      })}
    </div>
  );
}

// ── Buttons ─────────────────────────────────────────────────────────────
function PrimaryBtn({ children, t, onClick, style = {} }) {
  return (
    <button onClick={onClick} style={{
      width: '100%', padding: '16px 20px', borderRadius: 16, border: 0,
      background: t.accent, color: '#fff',
      fontSize: 17, fontWeight: 600, fontFamily: 'inherit',
      boxShadow: `0 6px 18px ${t.accent}33`,
      cursor: 'pointer', ...style,
    }}>{children}</button>
  );
}

function GhostBtn({ children, t, onClick, style = {} }) {
  return (
    <button onClick={onClick} style={{
      width: '100%', padding: '15px 20px', borderRadius: 16,
      border: `1px solid ${t.hair}`, background: t.card, color: t.ink,
      fontSize: 16, fontWeight: 600, fontFamily: 'inherit',
      cursor: 'pointer', ...style,
    }}>{children}</button>
  );
}

// ═══════════════════════════════════════════════════════════════════════
// SCREEN 1 — Splash / Sign in
// ═══════════════════════════════════════════════════════════════════════
function SplashScreen({ go, tweaks }) {
  const t = tokensFor(tweaks);
  return (
    <ScreenShell t={t} padTop={0}>
      <div style={{
        minHeight: 844, padding: '120px 28px 40px',
        display: 'flex', flexDirection: 'column',
        background: `radial-gradient(120% 60% at 50% 0%, ${t.accentSoft} 0%, transparent 70%), ${t.bg}`,
      }}>
        {/* Brand mark */}
        <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 36 }}>
          <div style={{
            width: 56, height: 56, borderRadius: 16, background: t.card,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            boxShadow: `0 8px 24px ${t.accent}22, 0 0 0 1px ${t.hair}`,
          }}>{Icon.logo(t.accent, 32)}</div>
          <div>
            <div style={{ fontSize: 22, fontWeight: 700, letterSpacing: -0.4 }}>contract<span style={{ color: t.accent }}>.ai</span></div>
            <div style={{ fontSize: 13, color: t.muted, marginTop: 2 }}>by Morning</div>
          </div>
        </div>

        <h1 style={{
          fontSize: 38, lineHeight: '42px', fontWeight: 700, letterSpacing: -1.2,
          margin: '40px 0 16px', textWrap: 'pretty',
        }}>
          Spot the fine print<br/>
          <span style={{ color: t.accent }}>in seconds.</span>
        </h1>
        <p style={{ fontSize: 16, lineHeight: '22px', color: t.ink2, margin: 0, maxWidth: 280 }}>
          Upload any contract — we'll flag what to watch for, in plain English.
        </p>

        <div style={{ flex: 1 }} />

        {/* Auth buttons */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
          <button onClick={() => go('home')} style={{
            width: '100%', padding: '15px 20px', borderRadius: 14, border: 0,
            background: '#000', color: '#fff',
            display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 8,
            fontSize: 16, fontWeight: 600, fontFamily: 'inherit', cursor: 'pointer',
          }}>
            <svg width="16" height="18" viewBox="0 0 16 18" fill="#fff"><path d="M11.5.5c.1 1-.3 2-.9 2.7-.6.7-1.6 1.3-2.5 1.2-.1-1 .4-2 1-2.6.6-.7 1.6-1.2 2.4-1.3zM14 13c-.4.9-.6 1.3-1.1 2-.7 1.1-1.7 2.5-3 2.5-1.1 0-1.4-.7-2.9-.7s-1.9.7-3 .7c-1.3 0-2.2-1.3-3-2.4C-1 12.6.1 8 2.6 7.1c.9-.3 1.7 0 2.5.3.6.2 1.2.5 1.9.5.7 0 1.3-.3 1.9-.5.9-.3 1.7-.7 2.7-.4 1.1.3 2 1.1 2.6 2.2-1.7.9-2.3 3.1-1.2 4.8z"/></svg>
            Continue with Apple
          </button>
          <button onClick={() => go('home')} style={{
            width: '100%', padding: '15px 20px', borderRadius: 14,
            border: `1px solid ${t.hair}`, background: t.card, color: t.ink,
            display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 8,
            fontSize: 16, fontWeight: 600, fontFamily: 'inherit', cursor: 'pointer',
          }}>
            <svg width="18" height="18" viewBox="0 0 18 18"><path d="M17.6 9.2c0-.6-.1-1.2-.2-1.7H9v3.3h4.8c-.2 1.1-.8 2-1.8 2.6v2.2h2.9c1.7-1.6 2.7-3.9 2.7-6.4z" fill="#4285F4"/><path d="M9 18c2.4 0 4.5-.8 6-2.2l-2.9-2.2c-.8.5-1.8.9-3.1.9-2.4 0-4.4-1.6-5.1-3.8H.9v2.3C2.4 15.9 5.4 18 9 18z" fill="#34A853"/><path d="M3.9 10.7c-.2-.5-.3-1.1-.3-1.7s.1-1.2.3-1.7V5H.9C.3 6.2 0 7.5 0 9s.3 2.8.9 4l3-2.3z" fill="#FBBC05"/><path d="M9 3.6c1.3 0 2.5.5 3.5 1.4l2.6-2.6C13.5.9 11.4 0 9 0 5.4 0 2.4 2.1.9 5l3 2.3C4.6 5.1 6.6 3.6 9 3.6z" fill="#EA4335"/></svg>
            Continue with Google
          </button>
          <button onClick={() => go('home')} style={{
            width: '100%', padding: '15px 20px', borderRadius: 14,
            border: `1px solid ${t.hair}`, background: t.card, color: t.ink,
            fontSize: 16, fontWeight: 600, fontFamily: 'inherit', cursor: 'pointer',
          }}>Continue with email</button>
          <p style={{ fontSize: 12, color: t.muted, textAlign: 'center', marginTop: 12, lineHeight: '18px' }}>
            By continuing, you agree to our <u>Terms</u> and <u>Privacy Policy</u>.
          </p>
        </div>
      </div>
    </ScreenShell>
  );
}

// ═══════════════════════════════════════════════════════════════════════
// SCREEN 2 — Home (empty + recent)
// ═══════════════════════════════════════════════════════════════════════
const RECENT = [
  { id: 'r1', name: 'Apartment lease — 235 Bowery', when: 'Yesterday', red: 2, amber: 4, blue: 3, status: 'Reviewed' },
  { id: 'r2', name: 'Freelance contract — Acme Co.', when: '3 days ago', red: 0, amber: 2, blue: 5, status: 'Reviewed' },
  { id: 'r3', name: 'Gym membership terms', when: 'Last week', red: 1, amber: 1, blue: 2, status: 'Reviewed' },
];

function HomeScreen({ go, tweaks, openSheet }) {
  const t = tokensFor(tweaks);
  return (
    <ScreenShell t={t}>
      <div style={{ padding: '8px 24px 110px' }}>
        {/* Greeting */}
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 24 }}>
          <div>
            <div style={{ fontSize: 14, color: t.muted, marginBottom: 2 }}>Tuesday · May 19</div>
            <div style={{ fontSize: 26, fontWeight: 700, letterSpacing: -0.6 }}>Hi, Sarah</div>
          </div>
          <button onClick={() => go('settings')} style={{
            width: 42, height: 42, borderRadius: 999, border: 0,
            background: t.accentSoft, color: t.accent,
            fontSize: 16, fontWeight: 700, cursor: 'pointer', fontFamily: 'inherit',
          }}>SK</button>
        </div>

        {/* Hero CTA card */}
        <button onClick={openSheet} style={{
          width: '100%', textAlign: 'left', border: 0, cursor: 'pointer',
          background: `linear-gradient(140deg, ${t.accent} 0%, ${t.accentDeep} 100%)`,
          borderRadius: 24, padding: '24px 22px',
          color: '#fff', fontFamily: 'inherit',
          boxShadow: `0 12px 30px ${t.accent}33`,
          position: 'relative', overflow: 'hidden',
        }}>
          <div style={{ position: 'absolute', right: -20, top: -20, opacity: 0.15 }}>
            {Icon.logo('#fff', 140)}
          </div>
          <div style={{
            display: 'inline-flex', alignItems: 'center', gap: 6,
            background: 'rgba(255,255,255,0.18)', padding: '5px 10px', borderRadius: 999,
            fontSize: 11, fontWeight: 600, marginBottom: 14,
          }}>
            {Icon.sparkle('#fff', 12)} Powered by AI
          </div>
          <div style={{ fontSize: 24, fontWeight: 700, lineHeight: '28px', letterSpacing: -0.4, marginBottom: 6 }}>
            Analyze a contract
          </div>
          <div style={{ fontSize: 14, opacity: 0.85, marginBottom: 18, maxWidth: 240 }}>
            Drop a PDF, snap a photo, or paste the text.
          </div>
          <div style={{
            display: 'inline-flex', alignItems: 'center', gap: 8,
            background: '#fff', color: t.accentDeep, padding: '10px 14px',
            borderRadius: 999, fontSize: 14, fontWeight: 600,
          }}>
            {Icon.upload(t.accentDeep, 16)} Choose source
          </div>
        </button>

        {/* Stats row */}
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 10, marginTop: 20 }}>
          {[
            { n: 12, l: 'Reviewed' },
            { n: 3,  l: 'Red flags', c: t.red },
            { n: 9,  l: 'Watch-outs', c: t.amber },
          ].map((s, i) => (
            <div key={i} style={{
              background: t.card, border: `1px solid ${t.hair}`,
              borderRadius: 14, padding: '12px 14px',
            }}>
              <div style={{ fontSize: 22, fontWeight: 700, color: s.c || t.ink, letterSpacing: -0.4 }}>{s.n}</div>
              <div style={{ fontSize: 11, color: t.muted, marginTop: 2 }}>{s.l}</div>
            </div>
          ))}
        </div>

        {/* Recent */}
        <div style={{ display: 'flex', alignItems: 'baseline', justifyContent: 'space-between', marginTop: 28, marginBottom: 12 }}>
          <h2 style={{ fontSize: 17, fontWeight: 700, margin: 0 }}>Recent</h2>
          <button onClick={() => go('history')} style={{
            background: 'transparent', border: 0, color: t.accent, fontSize: 13, fontWeight: 600,
            cursor: 'pointer', fontFamily: 'inherit',
          }}>See all</button>
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
          {RECENT.map(r => <RecentRow key={r.id} r={r} t={t} onClick={() => go('results')} />)}
        </div>
      </div>
      <TabBar active="home" go={go} t={t} />
    </ScreenShell>
  );
}

function RecentRow({ r, t, onClick }) {
  return (
    <button onClick={onClick} style={{
      width: '100%', textAlign: 'left', border: 0, cursor: 'pointer',
      background: t.card, padding: '14px 16px', borderRadius: 14,
      border: `1px solid ${t.hair}`,
      display: 'flex', alignItems: 'center', gap: 12, fontFamily: 'inherit',
    }}>
      <div style={{
        width: 40, height: 40, borderRadius: 12, background: t.accentSoft,
        display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0,
      }}>{Icon.doc(t.accent, 20)}</div>
      <div style={{ flex: 1, minWidth: 0 }}>
        <div style={{
          fontSize: 14, fontWeight: 600, color: t.ink, marginBottom: 4,
          whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis',
        }}>{r.name}</div>
        <div style={{ display: 'flex', gap: 10, alignItems: 'center', fontSize: 12, color: t.muted }}>
          <span>{r.when}</span>
          <span style={{ width: 3, height: 3, borderRadius: 99, background: t.muted }} />
          <span style={{ display: 'inline-flex', gap: 6, alignItems: 'center' }}>
            {r.red > 0 && <><SevDot kind="red" t={t} size={7}/>{r.red}</>}
            {r.amber > 0 && <><SevDot kind="amber" t={t} size={7}/>{r.amber}</>}
            {r.blue > 0 && <><SevDot kind="blue" t={t} size={7}/>{r.blue}</>}
          </span>
        </div>
      </div>
      {Icon.chevR(t.muted, 16)}
    </button>
  );
}

// ═══════════════════════════════════════════════════════════════════════
// Upload bottom sheet (overlay on home)
// ═══════════════════════════════════════════════════════════════════════
function UploadSheet({ open, onClose, go, tweaks }) {
  const t = tokensFor(tweaks);
  const sources = [
    { k: 'pdf',    icon: Icon.doc,    title: 'PDF or document',   sub: 'Files app',  next: 'analyzing' },
    { k: 'photo',  icon: Icon.camera, title: 'Photo or scan',     sub: 'Camera or library', next: 'analyzing' },
    { k: 'text',   icon: Icon.text,   title: 'Paste text',        sub: 'From clipboard',    next: 'analyzing' },
    { k: 'cloud',  icon: Icon.cloud,  title: 'Cloud storage',     sub: 'Drive, Dropbox, iCloud', next: 'analyzing' },
  ];
  return (
    <>
      {/* backdrop */}
      <div onClick={onClose} style={{
        position: 'absolute', inset: 0, background: 'rgba(0,0,0,0.4)',
        opacity: open ? 1 : 0, pointerEvents: open ? 'auto' : 'none',
        transition: 'opacity .22s ease', zIndex: 30,
      }} />
      {/* sheet */}
      <div style={{
        position: 'absolute', left: 0, right: 0, bottom: 0,
        background: t.card, borderRadius: '28px 28px 0 0',
        padding: '14px 20px 32px', zIndex: 31,
        transform: open ? 'translateY(0)' : 'translateY(110%)',
        transition: 'transform .28s cubic-bezier(.2,.7,.3,1)',
        boxShadow: '0 -20px 60px rgba(0,0,0,0.18)',
      }}>
        <div style={{ width: 40, height: 5, borderRadius: 99, background: t.hair, margin: '0 auto 14px' }} />
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
          <h3 style={{ fontSize: 20, fontWeight: 700, margin: 0, letterSpacing: -0.4 }}>Add a contract</h3>
          <button onClick={onClose} style={{
            width: 32, height: 32, borderRadius: 999, border: 0,
            background: t.bg, cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center',
          }}>{Icon.close(t.ink2, 18)}</button>
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
          {sources.map(s => (
            <button key={s.k} onClick={() => { onClose(); setTimeout(() => go(s.next), 120); }} style={{
              width: '100%', textAlign: 'left', border: 0, cursor: 'pointer',
              background: t.bg, padding: '14px 16px', borderRadius: 16,
              display: 'flex', alignItems: 'center', gap: 14, fontFamily: 'inherit',
            }}>
              <div style={{
                width: 42, height: 42, borderRadius: 12, background: t.accentSoft,
                display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0,
              }}>{s.icon(t.accent, 22)}</div>
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 15, fontWeight: 600, color: t.ink }}>{s.title}</div>
                <div style={{ fontSize: 12, color: t.muted, marginTop: 2 }}>{s.sub}</div>
              </div>
              {Icon.chevR(t.muted, 16)}
            </button>
          ))}
        </div>
      </div>
    </>
  );
}

// ═══════════════════════════════════════════════════════════════════════
// SCREEN — Analyzing animation
// ═══════════════════════════════════════════════════════════════════════
function AnalyzingScreen({ go, tweaks }) {
  const t = tokensFor(tweaks);
  const [stage, setStage] = React.useState(0); // 0..3
  React.useEffect(() => {
    const ts = [
      setTimeout(() => setStage(1), 900),
      setTimeout(() => setStage(2), 2000),
      setTimeout(() => setStage(3), 3000),
      setTimeout(() => go('results'), 3800),
    ];
    return () => ts.forEach(clearTimeout);
  }, []);
  const steps = [
    'Extracting text…',
    'Identifying clauses…',
    'Flagging risks…',
    'Done',
  ];
  return (
    <ScreenShell t={t} padTop={0}>
      <div style={{
        minHeight: 844, padding: '88px 28px 40px',
        display: 'flex', flexDirection: 'column', alignItems: 'center',
        background: `radial-gradient(80% 50% at 50% 35%, ${t.accentSoft} 0%, transparent 70%), ${t.bg}`,
      }}>
        {/* Animated doc with scanning line */}
        <div style={{ position: 'relative', width: 160, height: 200, marginTop: 60 }}>
          <div style={{
            width: '100%', height: '100%', borderRadius: 14, background: t.card,
            boxShadow: `0 20px 60px ${t.accent}22, 0 0 0 1px ${t.hair}`,
            padding: 18, display: 'flex', flexDirection: 'column', gap: 8,
            overflow: 'hidden', position: 'relative',
          }}>
            {[0.9, 0.7, 0.85, 0.4, 0.78, 0.6, 0.88, 0.5].map((w, i) => (
              <div key={i} style={{
                height: 6, borderRadius: 3, width: `${w * 100}%`,
                background: i === 2 ? t.accent : t.hair,
                opacity: i === 2 ? 0.9 : 1,
              }} />
            ))}
            {/* scan line */}
            <div style={{
              position: 'absolute', left: 0, right: 0, height: 22,
              background: `linear-gradient(180deg, transparent, ${t.accent}55, transparent)`,
              animation: 'scanY 1.4s ease-in-out infinite',
            }} />
          </div>
          <style>{`
            @keyframes scanY { 0%{top:-22px} 100%{top:200px} }
            @keyframes pulseDot { 0%,100%{opacity:0.3;transform:scale(0.85)} 50%{opacity:1;transform:scale(1)} }
          `}</style>
        </div>

        <div style={{ marginTop: 40, fontSize: 22, fontWeight: 700, letterSpacing: -0.5, textAlign: 'center' }}>
          Reading your contract
        </div>
        <div style={{ marginTop: 8, fontSize: 14, color: t.muted, textAlign: 'center', maxWidth: 260 }}>
          This usually takes 10–20 seconds. We process everything privately.
        </div>

        {/* Step list */}
        <div style={{ marginTop: 36, width: '100%', display: 'flex', flexDirection: 'column', gap: 10 }}>
          {steps.slice(0, 3).map((label, i) => {
            const done = stage > i;
            const active = stage === i;
            return (
              <div key={i} style={{
                display: 'flex', alignItems: 'center', gap: 12,
                padding: '12px 14px', borderRadius: 12,
                background: active ? t.accentSoft : t.card,
                border: `1px solid ${active ? t.accent + '66' : t.hair}`,
              }}>
                <div style={{
                  width: 22, height: 22, borderRadius: 99,
                  background: done ? t.green : (active ? t.accent : t.hair),
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  animation: active ? 'pulseDot 1s ease-in-out infinite' : 'none',
                }}>
                  {done && Icon.check('#fff', 14)}
                </div>
                <span style={{
                  fontSize: 14, fontWeight: 600,
                  color: done ? t.ink : (active ? t.ink : t.muted),
                }}>{label}</span>
              </div>
            );
          })}
        </div>

        <div style={{ flex: 1 }} />
        <button onClick={() => go('home')} style={{
          background: 'transparent', border: 0, color: t.muted, fontSize: 14, fontWeight: 500,
          cursor: 'pointer', fontFamily: 'inherit', padding: 12,
        }}>Cancel</button>
      </div>
    </ScreenShell>
  );
}

// ═══════════════════════════════════════════════════════════════════════
// SCREEN — Results (critical points list)
// ═══════════════════════════════════════════════════════════════════════
const ISSUES = [
  { id: 'i1', sev: 'red',   page: 4, title: 'Automatic 12-month renewal',
    snippet: 'Lease renews for an additional 12-month term unless tenant gives written notice 90 days before expiration.',
    why: "You're locked in for another year if you forget to give notice in time.",
    action: 'Add a calendar reminder for Feb 1, 2026 — or negotiate a 30-day window.' },
  { id: 'i2', sev: 'red',   page: 7, title: 'Landlord may enter with 12-hour notice',
    snippet: 'Landlord reserves the right to enter the premises with twelve (12) hours notice for inspection or maintenance.',
    why: 'NY state law typically requires 24 hours. This is shorter than usual.',
    action: 'Ask to raise to 24 hours and limit to business hours.' },
  { id: 'i3', sev: 'red',   page: 9, title: 'Tenant pays for all repairs over $50',
    snippet: 'Tenant shall be responsible for the cost of all repairs in excess of fifty dollars ($50).',
    why: 'That threshold is unusually low — a single appliance repair will exceed it.',
    action: 'Push the cap to $250–500, or have landlord cover appliances and structure.' },
  { id: 'i4', sev: 'amber', page: 3, title: 'Late fee: 8% of monthly rent',
    snippet: 'A late fee equal to eight percent (8%) of the monthly rent will be assessed after the 5th of the month.',
    why: 'Above the typical 5% market range, but legal in NY.' },
  { id: 'i5', sev: 'amber', page: 6, title: 'No subletting without consent',
    snippet: 'Tenant may not sublet or assign the premises without prior written consent of the landlord.',
    why: 'Standard, but consent is at landlord\'s sole discretion — push for "reasonable consent."' },
  { id: 'i6', sev: 'amber', page: 8, title: 'Security deposit held without interest',
    snippet: 'The security deposit shall be held in an interest-free account during the tenancy.',
    why: 'In NYC, deposits on units in 6+ unit buildings must accrue interest.' },
  { id: 'i7', sev: 'amber', page: 10, title: 'Pet deposit non-refundable',
    snippet: 'A non-refundable pet fee of $500 is required at signing.',
    why: 'Common, but worth confirming this is separate from your security deposit.' },
  { id: 'i8', sev: 'blue',  page: 1, title: 'Rent: $3,200/month',
    snippet: 'Monthly rent of three thousand two hundred dollars ($3,200), due on the 1st.', why: 'Confirmed base rent.' },
  { id: 'i9', sev: 'blue',  page: 2, title: 'Term: 12 months',
    snippet: 'The initial term is twelve (12) months commencing June 1, 2026.', why: 'Standard one-year lease.' },
  { id: 'i10', sev: 'blue', page: 12, title: 'Governing law: New York',
    snippet: 'This Lease shall be governed by the laws of the State of New York.', why: 'Applies if any dispute goes to court.' },
];

function ResultsScreen({ go, tweaks, openIssue }) {
  const t = tokensFor(tweaks);
  const [filter, setFilter] = React.useState('all');
  const filtered = filter === 'all' ? ISSUES : ISSUES.filter(i => i.sev === filter);
  const cntR = ISSUES.filter(i => i.sev === 'red').length;
  const cntA = ISSUES.filter(i => i.sev === 'amber').length;
  const cntB = ISSUES.filter(i => i.sev === 'blue').length;

  return (
    <ScreenShell t={t} padTop={0}>
      {/* Header */}
      <div style={{
        padding: '54px 20px 16px', background: t.card,
        borderBottom: `1px solid ${t.hair}`, position: 'sticky', top: 0, zIndex: 4,
      }}>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 12 }}>
          <button onClick={() => go('home')} style={{ background: 'transparent', border: 0, padding: 8, marginLeft: -8, cursor: 'pointer' }}>
            {Icon.back(t.ink, 22)}
          </button>
          <div style={{ display: 'flex', gap: 4 }}>
            <button style={{ background: 'transparent', border: 0, padding: 8, cursor: 'pointer' }}>{Icon.share(t.ink, 20)}</button>
            <button style={{ background: 'transparent', border: 0, padding: 8, cursor: 'pointer' }}>{Icon.more(t.ink, 22)}</button>
          </div>
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
          <div style={{
            width: 44, height: 44, borderRadius: 12, background: t.accentSoft,
            display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0,
          }}>{Icon.doc(t.accent, 22)}</div>
          <div style={{ flex: 1, minWidth: 0 }}>
            <div style={{ fontSize: 17, fontWeight: 700, letterSpacing: -0.3, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
              Apartment lease — 235 Bowery
            </div>
            <div style={{ fontSize: 12, color: t.muted, marginTop: 2 }}>14 pages · Reviewed in 18s</div>
          </div>
        </div>

        {/* AI summary */}
        <div style={{
          marginTop: 14, padding: '12px 14px', borderRadius: 12,
          background: t.accentSoft,
          display: 'flex', gap: 10,
        }}>
          {Icon.sparkle(t.accent, 16)}
          <div style={{ fontSize: 13, lineHeight: '19px', color: t.accentDeep, flex: 1 }}>
            <strong style={{ fontWeight: 700 }}>Mostly fair, with 3 things to push back on.</strong> The auto-renewal and repair threshold stand out — both negotiable.
          </div>
        </div>

        {/* Filter chips */}
        <div style={{ display: 'flex', gap: 6, marginTop: 14, overflowX: 'auto', paddingBottom: 2 }}>
          <Chip on={filter === 'all'} onClick={() => setFilter('all')} t={t}>
            All {ISSUES.length}
          </Chip>
          <Chip on={filter === 'red'} onClick={() => setFilter('red')} t={t} dot="red">
            Red flags {cntR}
          </Chip>
          <Chip on={filter === 'amber'} onClick={() => setFilter('amber')} t={t} dot="amber">
            Watch-outs {cntA}
          </Chip>
          <Chip on={filter === 'blue'} onClick={() => setFilter('blue')} t={t} dot="blue">
            FYI {cntB}
          </Chip>
        </div>
      </div>

      {/* List */}
      <div style={{ padding: '14px 20px 40px', display: 'flex', flexDirection: 'column', gap: 10 }}>
        {filtered.map(issue => <IssueCard key={issue.id} issue={issue} t={t} chipStyle={tweaks.sevStyle} onClick={() => openIssue(issue.id)} />)}
      </div>
    </ScreenShell>
  );
}

function Chip({ children, on, onClick, t, dot }) {
  return (
    <button onClick={onClick} style={{
      flexShrink: 0, padding: '7px 12px', borderRadius: 999,
      border: `1px solid ${on ? t.accent : t.hair}`,
      background: on ? t.accent : t.card, color: on ? '#fff' : t.ink,
      fontSize: 13, fontWeight: 600, fontFamily: 'inherit', cursor: 'pointer',
      display: 'inline-flex', alignItems: 'center', gap: 6,
    }}>
      {dot && <SevDot kind={dot} t={t} size={7} />}
      {children}
    </button>
  );
}

function IssueCard({ issue, t, chipStyle = 'soft', onClick }) {
  const c = sevColor(t, issue.sev);
  return (
    <button onClick={onClick} style={{
      width: '100%', textAlign: 'left', border: 0, cursor: 'pointer',
      background: t.card, borderRadius: 14, padding: '14px 16px',
      border: `1px solid ${t.hair}`,
      display: 'flex', flexDirection: 'column', gap: 8, fontFamily: 'inherit',
      position: 'relative', overflow: 'hidden',
    }}>
      {/* left severity bar */}
      <span style={{ position: 'absolute', left: 0, top: 0, bottom: 0, width: 4, background: c.fg }} />
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 8 }}>
        <SevChip kind={issue.sev} t={t} style={chipStyle} size="sm"/>
        <span style={{ fontSize: 11, color: t.muted, fontWeight: 500 }}>p. {issue.page}</span>
      </div>
      <div style={{ fontSize: 15, fontWeight: 600, lineHeight: '20px', color: t.ink, letterSpacing: -0.2 }}>
        {issue.title}
      </div>
      <div style={{
        fontSize: 13, lineHeight: '19px', color: t.ink2,
        display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical',
        overflow: 'hidden',
      }}>"{issue.snippet}"</div>
    </button>
  );
}

// ═══════════════════════════════════════════════════════════════════════
// SCREEN — Issue detail
// ═══════════════════════════════════════════════════════════════════════
function IssueDetailScreen({ go, tweaks, issueId, back }) {
  const t = tokensFor(tweaks);
  const issue = ISSUES.find(i => i.id === issueId) || ISSUES[0];
  const c = sevColor(t, issue.sev);
  return (
    <ScreenShell t={t} padTop={0}>
      {/* Header */}
      <div style={{ padding: '54px 20px 14px', background: t.card, borderBottom: `1px solid ${t.hair}` }}>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
          <button onClick={back} style={{ background: 'transparent', border: 0, padding: 8, marginLeft: -8, cursor: 'pointer' }}>
            {Icon.back(t.ink, 22)}
          </button>
          <div style={{ fontSize: 13, color: t.muted, fontWeight: 600 }}>Issue 1 of 3</div>
          <button style={{ background: 'transparent', border: 0, padding: 8, cursor: 'pointer' }}>{Icon.more(t.ink, 22)}</button>
        </div>
      </div>

      <div style={{ padding: '20px 22px 120px' }}>
        <SevChip kind={issue.sev} t={t} style={tweaks.sevStyle} />
        <h1 style={{
          fontSize: 26, fontWeight: 700, lineHeight: '30px', letterSpacing: -0.6,
          margin: '14px 0 6px', color: t.ink,
        }}>{issue.title}</h1>
        <div style={{ fontSize: 13, color: t.muted, marginBottom: 22 }}>
          Found on page {issue.page} · Clause 7.2
        </div>

        {/* What it says */}
        <Section t={t} label="What the contract says">
          <div style={{
            background: t.bg, borderLeft: `3px solid ${c.fg}`, padding: '14px 16px',
            borderRadius: 8, fontSize: 14, lineHeight: '21px', color: t.ink,
            fontStyle: 'italic',
          }}>"{issue.snippet}"</div>
        </Section>

        {/* Why it matters */}
        <Section t={t} label="Why it matters">
          <p style={{ fontSize: 15, lineHeight: '23px', color: t.ink, margin: 0 }}>{issue.why}</p>
        </Section>

        {/* Suggested action */}
        {issue.action && (
          <Section t={t} label="Suggested action">
            <div style={{
              background: t.accentSoft, padding: '14px 16px', borderRadius: 12,
              display: 'flex', gap: 10, alignItems: 'flex-start',
            }}>
              {Icon.sparkle(t.accent, 18)}
              <p style={{ fontSize: 14, lineHeight: '21px', color: t.accentDeep, margin: 0, flex: 1 }}>{issue.action}</p>
            </div>
          </Section>
        )}

        {/* Actions */}
        <div style={{ display: 'flex', gap: 10, marginTop: 28 }}>
          <button style={{
            flex: 1, padding: '13px', borderRadius: 12, border: `1px solid ${t.hair}`,
            background: t.card, color: t.ink, fontSize: 14, fontWeight: 600,
            fontFamily: 'inherit', cursor: 'pointer',
            display: 'inline-flex', alignItems: 'center', justifyContent: 'center', gap: 6,
          }}>{Icon.eye(t.ink2, 16)} Show in doc</button>
          <button style={{
            flex: 1, padding: '13px', borderRadius: 12, border: 0,
            background: t.ink, color: t.bg, fontSize: 14, fontWeight: 600,
            fontFamily: 'inherit', cursor: 'pointer',
          }}>Ask follow-up</button>
        </div>
      </div>

      {/* Floating prev/next */}
      <div style={{
        position: 'absolute', left: 20, right: 20, bottom: 28,
        background: t.card, borderRadius: 16, padding: 8,
        border: `1px solid ${t.hair}`, boxShadow: '0 8px 30px rgba(0,0,0,0.08)',
        display: 'flex', gap: 6, zIndex: 5,
      }}>
        <button style={{
          flex: 1, padding: '10px', borderRadius: 10, border: 0, background: t.bg,
          color: t.ink, fontSize: 13, fontWeight: 600, fontFamily: 'inherit', cursor: 'pointer',
          display: 'inline-flex', alignItems: 'center', justifyContent: 'center', gap: 4,
        }}>{Icon.back(t.ink, 16)} Previous</button>
        <button onClick={back} style={{
          flex: 1, padding: '10px', borderRadius: 10, border: 0, background: t.accent,
          color: '#fff', fontSize: 13, fontWeight: 600, fontFamily: 'inherit', cursor: 'pointer',
          display: 'inline-flex', alignItems: 'center', justifyContent: 'center', gap: 4,
        }}>Next {Icon.chevR('#fff', 16)}</button>
      </div>
    </ScreenShell>
  );
}

function Section({ label, children, t }) {
  return (
    <div style={{ marginBottom: 22 }}>
      <div style={{
        fontSize: 11, fontWeight: 700, color: t.muted, textTransform: 'uppercase',
        letterSpacing: 0.8, marginBottom: 8,
      }}>{label}</div>
      {children}
    </div>
  );
}

// ═══════════════════════════════════════════════════════════════════════
// SCREEN — History
// ═══════════════════════════════════════════════════════════════════════
const HISTORY_ALL = [
  { id: 'h1', name: 'Apartment lease — 235 Bowery', when: 'Yesterday',  group: 'This week', red: 3, amber: 4, blue: 3 },
  { id: 'h2', name: 'Freelance contract — Acme Co.', when: '3 days ago', group: 'This week', red: 0, amber: 2, blue: 5 },
  { id: 'h3', name: 'Gym membership terms',          when: '6 days ago', group: 'This week', red: 1, amber: 1, blue: 2 },
  { id: 'h4', name: 'Auto loan agreement',           when: 'May 8',      group: 'Earlier in May', red: 2, amber: 3, blue: 1 },
  { id: 'h5', name: 'Co-working space membership',   when: 'May 2',      group: 'Earlier in May', red: 0, amber: 1, blue: 3 },
  { id: 'h6', name: 'Phone carrier agreement',       when: 'April 22',   group: 'April', red: 1, amber: 5, blue: 2 },
];

function HistoryScreen({ go, tweaks }) {
  const t = tokensFor(tweaks);
  const groups = HISTORY_ALL.reduce((acc, h) => {
    (acc[h.group] = acc[h.group] || []).push(h);
    return acc;
  }, {});
  return (
    <ScreenShell t={t}>
      <div style={{ padding: '8px 24px 110px' }}>
        <div style={{ fontSize: 28, fontWeight: 700, letterSpacing: -0.6, marginBottom: 4 }}>History</div>
        <div style={{ fontSize: 14, color: t.muted, marginBottom: 18 }}>{HISTORY_ALL.length} contracts reviewed</div>

        {/* Search */}
        <div style={{
          display: 'flex', alignItems: 'center', gap: 8,
          background: t.card, borderRadius: 12, padding: '11px 14px',
          border: `1px solid ${t.hair}`, marginBottom: 22,
        }}>
          {Icon.search(t.muted, 18)}
          <input placeholder="Search contracts" style={{
            flex: 1, border: 0, outline: 0, background: 'transparent', fontSize: 14,
            color: t.ink, fontFamily: 'inherit',
          }}/>
        </div>

        {Object.entries(groups).map(([g, items]) => (
          <div key={g} style={{ marginBottom: 22 }}>
            <div style={{
              fontSize: 11, textTransform: 'uppercase', color: t.muted,
              fontWeight: 700, letterSpacing: 0.8, marginBottom: 10,
            }}>{g}</div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
              {items.map(r => <RecentRow key={r.id} r={r} t={t} onClick={() => go('results')} />)}
            </div>
          </div>
        ))}
      </div>
      <TabBar active="history" go={go} t={t} />
    </ScreenShell>
  );
}

// ═══════════════════════════════════════════════════════════════════════
// SCREEN — Settings / Profile
// ═══════════════════════════════════════════════════════════════════════
function SettingsScreen({ go, tweaks }) {
  const t = tokensFor(tweaks);
  return (
    <ScreenShell t={t}>
      <div style={{ padding: '8px 24px 110px' }}>
        <div style={{ fontSize: 28, fontWeight: 700, letterSpacing: -0.6, marginBottom: 22 }}>You</div>

        {/* Profile card */}
        <div style={{
          background: t.card, borderRadius: 18, padding: 18,
          border: `1px solid ${t.hair}`, marginBottom: 14,
          display: 'flex', alignItems: 'center', gap: 14,
        }}>
          <div style={{
            width: 56, height: 56, borderRadius: 999, background: t.accentSoft,
            color: t.accent, fontWeight: 700, fontSize: 20,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
          }}>SK</div>
          <div style={{ flex: 1 }}>
            <div style={{ fontSize: 17, fontWeight: 700, color: t.ink }}>Sarah Kim</div>
            <div style={{ fontSize: 13, color: t.muted, marginTop: 2 }}>sarah@kim.co</div>
          </div>
          <button style={{
            background: 'transparent', border: `1px solid ${t.hair}`,
            padding: '7px 12px', borderRadius: 999,
            fontSize: 12, fontWeight: 600, color: t.ink, fontFamily: 'inherit', cursor: 'pointer',
          }}>Edit</button>
        </div>

        {/* Plan */}
        <div style={{
          background: `linear-gradient(135deg, ${t.accent} 0%, ${t.accentDeep} 100%)`,
          color: '#fff', borderRadius: 18, padding: 18, marginBottom: 22,
          position: 'relative', overflow: 'hidden',
        }}>
          <div style={{ position: 'absolute', right: -10, bottom: -20, opacity: 0.18 }}>
            {Icon.sparkle('#fff', 100)}
          </div>
          <div style={{ fontSize: 12, opacity: 0.85, fontWeight: 600, letterSpacing: 0.4, textTransform: 'uppercase', marginBottom: 6 }}>Free plan</div>
          <div style={{ fontSize: 20, fontWeight: 700, letterSpacing: -0.3, marginBottom: 4 }}>3 of 5 contracts used</div>
          <div style={{ fontSize: 13, opacity: 0.8, marginBottom: 14 }}>Upgrade for unlimited reviews & priority models.</div>
          <div style={{ height: 6, borderRadius: 99, background: 'rgba(255,255,255,0.25)', overflow: 'hidden', marginBottom: 14 }}>
            <div style={{ width: '60%', height: '100%', background: '#fff' }} />
          </div>
          <button style={{
            background: '#fff', color: t.accentDeep, border: 0,
            padding: '9px 14px', borderRadius: 999,
            fontSize: 13, fontWeight: 700, fontFamily: 'inherit', cursor: 'pointer',
          }}>Upgrade to Pro · $9/mo</button>
        </div>

        {/* Section: Preferences */}
        <SettingGroup t={t} title="Preferences" rows={[
          { label: 'Notifications',     value: 'On' },
          { label: 'Severity labels',   value: 'Red flags / Watch-outs / FYI' },
          { label: 'Language',          value: 'English (US)' },
          { label: 'Appearance',        value: 'System' },
        ]}/>

        <SettingGroup t={t} title="Privacy" rows={[
          { label: 'Auto-delete after 30 days', value: 'On' },
          { label: 'Allow analytics',           value: 'Off' },
          { label: 'Export my data' },
        ]}/>

        <SettingGroup t={t} title="About" rows={[
          { label: 'Help & support' },
          { label: 'Terms of service' },
          { label: 'Privacy policy' },
        ]}/>

        <button style={{
          width: '100%', padding: '14px', borderRadius: 14, border: `1px solid ${t.hair}`,
          background: t.card, color: t.red, fontSize: 15, fontWeight: 600,
          fontFamily: 'inherit', cursor: 'pointer', marginTop: 4,
        }}>Sign out</button>

        <div style={{ textAlign: 'center', fontSize: 11, color: t.muted, marginTop: 18 }}>
          contract.ai · v0.1.0 (MVP)
        </div>
      </div>
      <TabBar active="settings" go={go} t={t} />
    </ScreenShell>
  );
}

function SettingGroup({ title, rows, t }) {
  return (
    <>
      <div style={{
        fontSize: 11, textTransform: 'uppercase', color: t.muted, fontWeight: 700,
        letterSpacing: 0.8, margin: '6px 4px 8px',
      }}>{title}</div>
      <div style={{
        background: t.card, borderRadius: 14, border: `1px solid ${t.hair}`,
        marginBottom: 18, overflow: 'hidden',
      }}>
        {rows.map((r, i) => (
          <div key={i} style={{
            display: 'flex', alignItems: 'center', padding: '13px 16px',
            borderBottom: i === rows.length - 1 ? 0 : `1px solid ${t.hair}`,
          }}>
            <div style={{ flex: 1, fontSize: 15, color: t.ink }}>{r.label}</div>
            {r.value && <div style={{ fontSize: 13, color: t.muted, marginRight: 6 }}>{r.value}</div>}
            {Icon.chevR(t.muted, 14)}
          </div>
        ))}
      </div>
    </>
  );
}

// Export to window for cross-file access
Object.assign(window, {
  SplashScreen, HomeScreen, UploadSheet, AnalyzingScreen,
  ResultsScreen, IssueDetailScreen, HistoryScreen, SettingsScreen,
  tokensFor, Icon, ISSUES,
});
