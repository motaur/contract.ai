// app.jsx — wires screens into a Design Canvas + Tweaks panel
// Each screen renders inside an <IOSDevice> at 390×844.

const DEVICE_W = 390;
const DEVICE_H = 844;

const TWEAK_DEFAULTS = /*EDITMODE-BEGIN*/{
  "accent": "#d97757",
  "sevStyle": "soft",
  "dark": false
}/*EDITMODE-END*/;

// One screen wrapped in an iPhone — used in static artboards
function StaticScreen({ Component, tweaks, extraProps = {} }) {
  const noop = () => {};
  return (
    <IOSDevice width={DEVICE_W} height={DEVICE_H} dark={tweaks.dark}>
      <Component go={noop} tweaks={tweaks} openSheet={noop} openIssue={noop} back={noop} {...extraProps} />
    </IOSDevice>
  );
}

// Special: Home with the upload sheet visibly half-open (showcase)
function HomeWithSheet({ tweaks }) {
  return (
    <IOSDevice width={DEVICE_W} height={DEVICE_H} dark={tweaks.dark}>
      <div style={{ position: 'relative', width: '100%', height: '100%' }}>
        <HomeScreen go={() => {}} tweaks={tweaks} openSheet={() => {}} />
        <UploadSheet open={true} onClose={() => {}} go={() => {}} tweaks={tweaks} />
      </div>
    </IOSDevice>
  );
}

// Issue detail artboard — pick one of the red flags
function IssueDetailArtboard({ tweaks }) {
  return (
    <IOSDevice width={DEVICE_W} height={DEVICE_H} dark={tweaks.dark}>
      <IssueDetailScreen go={() => {}} tweaks={tweaks} issueId="i1" back={() => {}} />
    </IOSDevice>
  );
}

// ─── Live interactive flow ────────────────────────────────────────────────
function LiveFlow({ tweaks }) {
  const [screen, setScreen] = React.useState('splash');
  const [issueId, setIssueId] = React.useState(null);
  const [sheet, setSheet] = React.useState(false);
  const [prev, setPrev] = React.useState('home');

  const go = (next) => {
    if (next !== 'detail') setPrev(next);
    setScreen(next);
  };
  const openIssue = (id) => { setIssueId(id); setScreen('detail'); };

  const props = { go, tweaks, openSheet: () => setSheet(true) };

  return (
    <IOSDevice width={DEVICE_W} height={DEVICE_H} dark={tweaks.dark}>
      <div style={{ position: 'relative', width: '100%', height: '100%' }}>
        {screen === 'splash'    && <SplashScreen {...props} />}
        {screen === 'home'      && <HomeScreen {...props} />}
        {screen === 'analyzing' && <AnalyzingScreen {...props} />}
        {screen === 'results'   && <ResultsScreen {...props} openIssue={openIssue} />}
        {screen === 'detail'    && <IssueDetailScreen {...props} issueId={issueId} back={() => setScreen('results')} />}
        {screen === 'history'   && <HistoryScreen {...props} />}
        {screen === 'settings'  && <SettingsScreen {...props} />}
        {screen !== 'splash' && screen !== 'analyzing' && screen !== 'detail' && screen !== 'results' && (
          <UploadSheet open={sheet} onClose={() => setSheet(false)} go={go} tweaks={tweaks} />
        )}
        {(screen === 'home') && (
          <UploadSheet open={sheet} onClose={() => setSheet(false)} go={go} tweaks={tweaks} />
        )}
        {/* Floating restart pill */}
        <button onClick={() => { setSheet(false); setScreen('splash'); }} style={{
          position: 'absolute', top: 14, right: 14, zIndex: 100,
          background: 'rgba(0,0,0,0.55)', color: '#fff', border: 0,
          padding: '6px 10px', borderRadius: 999, fontSize: 11,
          fontFamily: 'inherit', cursor: 'pointer', backdropFilter: 'blur(8px)',
        }}>↻ Restart flow</button>
      </div>
    </IOSDevice>
  );
}

// ─── Root app ─────────────────────────────────────────────────────────────
function App() {
  const [t, setTweak] = useTweaks(TWEAK_DEFAULTS);

  // Section ordering for the canvas
  return (
    <>
      <DesignCanvas>
        <DCSection id="flow" title="Live interactive flow" subtitle="Tap through the full prototype — sign in, upload, analyze, drill into issues. Restart any time.">
          <DCArtboard id="live" label="Tap to start" width={DEVICE_W} height={DEVICE_H}>
            <LiveFlow tweaks={t} />
          </DCArtboard>
        </DCSection>

        <DCSection id="onboarding" title="1 · Onboarding" subtitle="Splash & sign-in. Warm radial wash sets the tone.">
          <DCArtboard id="splash" label="01 · Splash / Sign in" width={DEVICE_W} height={DEVICE_H}>
            <StaticScreen Component={SplashScreen} tweaks={t} />
          </DCArtboard>
        </DCSection>

        <DCSection id="upload" title="2 · Home & upload" subtitle="Empty state with recents · upload bottom-sheet">
          <DCArtboard id="home" label="02 · Home" width={DEVICE_W} height={DEVICE_H}>
            <StaticScreen Component={HomeScreen} tweaks={t} />
          </DCArtboard>
          <DCArtboard id="upload-sheet" label="03 · Upload sources sheet" width={DEVICE_W} height={DEVICE_H}>
            <HomeWithSheet tweaks={t} />
          </DCArtboard>
          <DCArtboard id="analyzing" label="04 · Analyzing" width={DEVICE_W} height={DEVICE_H}>
            <StaticScreen Component={AnalyzingScreen} tweaks={t} />
          </DCArtboard>
        </DCSection>

        <DCSection id="results" title="3 · Results" subtitle="Critical points list + issue deep-dive">
          <DCArtboard id="results" label="05 · Results — critical points" width={DEVICE_W} height={DEVICE_H}>
            <StaticScreen Component={ResultsScreen} tweaks={t} />
          </DCArtboard>
          <DCArtboard id="detail" label="06 · Issue detail" width={DEVICE_W} height={DEVICE_H}>
            <IssueDetailArtboard tweaks={t} />
          </DCArtboard>
        </DCSection>

        <DCSection id="profile" title="4 · History & you" subtitle="Past reviews, plan, preferences">
          <DCArtboard id="history" label="07 · History" width={DEVICE_W} height={DEVICE_H}>
            <StaticScreen Component={HistoryScreen} tweaks={t} />
          </DCArtboard>
          <DCArtboard id="settings" label="08 · You / Settings" width={DEVICE_W} height={DEVICE_H}>
            <StaticScreen Component={SettingsScreen} tweaks={t} />
          </DCArtboard>
        </DCSection>
      </DesignCanvas>

      <TweaksPanel title="Tweaks">
        <TweakSection label="Brand">
          <TweakColor
            label="Accent"
            value={t.accent}
            onChange={v => setTweak('accent', v)}
            options={['#d97757', '#0a7d5a', '#1f3a8a', '#111111', '#8d3deb']}
          />
          <TweakToggle
            label="Dark mode"
            value={t.dark}
            onChange={v => setTweak('dark', v)}
          />
        </TweakSection>
        <TweakSection label="Severity">
          <TweakRadio
            label="Style"
            value={t.sevStyle}
            onChange={v => setTweak('sevStyle', v)}
            options={[
              { value: 'soft', label: 'Soft' },
              { value: 'solid', label: 'Solid' },
            ]}
          />
        </TweakSection>
      </TweaksPanel>
    </>
  );
}

ReactDOM.createRoot(document.getElementById('root')).render(<App />);
