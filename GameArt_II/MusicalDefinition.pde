//--------------------- User keys Definition -----------------

char[] userPiano = {'a', 'w', 's', 'e', 'd', 'f','t', 'g', 'y', 'h', 'u', 'j'};

char C_KEY = 'a';
char D_KEY = 's';
char E_KEY = 'd';
char F_KEY = 'f';
char G_KEY = 'g';
char A_KEY = 'h';
char B_KEY = 'j';

char Db_KEY = 'w';
char Eb_KEY = 'e';
char Gb_KEY = 't';
char Ab_KEY = 'y';
char Bb_KEY = 'u';

//--------------------- User keys Definition -----------------


//----------------------- Chord Definition -------------------

Scale cMajor;    Scale cMinorN;    Scale cMinorH;
Scale dMajor;    Scale dMinorN;    Scale dMinorH;
Scale eMajor;    Scale eMinorN;    Scale eMinorH;
Scale fMajor;    Scale fMinorN;    Scale fMinorH;
Scale gMajor;    Scale gMinorN;    Scale gMinorH;
Scale aMajor;    Scale aMinorN;    Scale aMinorH;
Scale bMajor;    Scale bMinorN;    Scale bMinorH;

//----------------------- Chord Definition -------------------


//--------------------- Chord Initialization -----------------

public void SetupChords()
{
    cMajor = new Scale(ScaleName.C, ScaleType.Major, 0);
    dMajor = new Scale(ScaleName.D, ScaleType.Major, 0);
    eMajor = new Scale(ScaleName.E, ScaleType.Major, 0);
    fMajor = new Scale(ScaleName.F, ScaleType.Major, 0);
    gMajor = new Scale(ScaleName.G, ScaleType.Major, 0);
    aMajor = new Scale(ScaleName.A, ScaleType.Major, 0);
    bMajor = new Scale(ScaleName.B, ScaleType.Major, 0);
}

public void SetupMinorHarmonicChords()
{
    cMinorH = new Scale(ScaleName.C, ScaleType.Minor_Harmonic, 0);
    dMinorH = new Scale(ScaleName.D, ScaleType.Minor_Harmonic, 0);
    eMinorH = new Scale(ScaleName.E, ScaleType.Minor_Harmonic, 0);
    fMinorH = new Scale(ScaleName.F, ScaleType.Minor_Harmonic, 0);
    gMinorH = new Scale(ScaleName.G, ScaleType.Minor_Harmonic, 0);
    aMinorH = new Scale(ScaleName.A, ScaleType.Minor_Harmonic, 0);
    bMinorH = new Scale(ScaleName.B, ScaleType.Minor_Harmonic, 0);
}

//--------------------- Chord Initialization -----------------


//-------------------- Background sound player ---------------

TriOsc bkg_osc;
Env bkg_env;

PlayerConfig bkg_pConfig;
NotePlayer bkg_player;

public void SetupBackgoundPlayer()
{
   bkg_osc = new TriOsc(this);
   bkg_env = new Env(this);
   
   bkg_pConfig = new PlayerConfig(0.001f, 0.225f, 0.25f, 0.001f, 0.3f);
   bkg_player = new ChordPlayer(bkg_osc, bkg_env, bkg_pConfig);
}

//-------------------- Background sound player ---------------

//-------------------- Boid sound player ---------------

TriOsc boid_osc;
Env boid_env;

PlayerConfig boid_pConfig;
NotePlayer boid_player;

public void SetupBoidPlayer()
{
   boid_osc = new TriOsc(this);
   boid_env = new Env(this);
   
   boid_pConfig = new PlayerConfig(0.001f, 0.1f, 0.25f, 0.001f, 0.3f);
   boid_player = new ArpeggioPlayer(bkg_osc, bkg_env, bkg_pConfig);
}

//-------------------- Background sound player ---------------