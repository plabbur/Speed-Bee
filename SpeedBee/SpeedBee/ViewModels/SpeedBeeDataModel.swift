//
//  SpeedBeeDataModel.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import Foundation
import SwiftUI

class SpeedBeeDataModel: ObservableObject {
    @AppStorage("SoundsOn") var soundsOn: Bool = false
    @AppStorage("VibrationOn") var vibrationOn: Bool = false
    @AppStorage("HintsOn") var hintsOn: Bool = false
    @AppStorage("LimitMistakes") var limitMistakesOn: Bool = true
    
    @Published var timePause = false
    @Published var timePlayed = 0
    @Published var timeRemaining = 0
    @Published var gameModeDelay = true
    @Published var gameOver = true
    
    @State var currentWord = ""
    @Published var newWord = false
    @Published var wordsFound = [String]()
    
    @Published var showHint = false
    @Published var onScreen: viewMode = viewMode.HOME
    @Published var showLevels = false
    
    var lettersChosen: [String] = ["A", "B", "C", "D", "E", "F", "G"]
    var letterCenter: String = "A"
    var lettersOther: [String] = ["B", "C", "D", "E", "F", "G"]
    var pointsReceived = 0
    var errorFound = Bool()
    var currentStat: Statistic
    var chosenPangram = String()
    var pangramList = [String]()
    var mistakeCounter = 0
    var hintChars: String = ""
    
    enum viewMode {
        case GAME
        case HOME
        case STATISTICS
        case ENDGAME
        case OPTIONS
    }
    
    var playedWords: [String] = []
    var possibleWords: [String] = ["ABANDONING", "ABDICATE", "ABDICATED", "ABDOMEN", "ABNORMAL", "ABOMINATION", "ACCLIMATE", "ACCOMPANY", "ACCORDION", "ACCRUING", "ACOLYTE", "ACQUAINT", "ACRIDITY", "ACRIDLY", "ACRONYM", "ACTUALITY", "ADAMANTLY", "ADAPTATION", "ADAPTING", "ADAPTION", "ADDICTION", "ADDITIONAL", "ADJACENCY", "ADJOURN", "ADJUNCT", "ADMONITION", "ADOPTION", "ADORABLY", "ADVANTAGE", "ADVANTAGED", "AFFIRMING", "AFFLUENT", "AGROUND", "AIRFLOW", "ALCHEMY", "ALLEGIANCE", "ALLEVIATED", "ALLIGATOR", "ALLOWANCE", "ALLOYING", "ALLURING", "ALPHABET", "ALRIGHT", "ALTHOUGH", "ALTITUDINAL", "AMBIANCE", "AMBIENCE", "AMBIENT", "AMBITION", "AMBULANT", "AMBULATE", "AMBULETTE", "AMENABLY", "AMENITY", "AMICABLE", "AMICABLY", "AMPHIBIAN", "AMPLIFY", "ANALOGIZING", "ANALYTIC", "ANALYTICAL", "ANALYTICALLY", "ANALYTICITY", "ANALYZABLE", "ANALYZED", "ANALYZING", "ANARCHICAL", "ANCHORMAN", "ANCHOVY", "ANGELIC", "ANGELICA", "ANKLEBONE", "ANNIHILATE", "ANNIHILATION", "ANNOYINGLY", "ANTAGONIZING", "ANTIAIRCRAFT", "ANTICALLY", "ANTICIPATE", "ANTICLIMACTIC", "ANTIOXIDANT", "ANTIPATHY", "ANYPLACE", "ANYTIME", "APLENTY", "APOCRYPHA", "APOLITICAL", "APPENDIX", "APPLEJACK", "APPLIANCE", "APPLICABLE", "APPLICANT", "APRICOT", "AQUACULTURAL", "ARACHNID", "ARCHIVAL", "ARCHRIVAL", "ARGONAUT", "ARGUABLY", "ARMADILLO", "ARMLOCK", "AROMATIC", "ARRHYTHMIA", "ARTFULLY", "ARTHRALGIA", "ARTHROPOD", "ATHLETIC", "ATROPHY", "ATTACHMENT", "ATTACKING", "ATTAINABILITY", "ATTITUDINAL", "AUDIBLY", "AUDITING", "AUTOCRACY", "AUTONOMY", "AUXILIARY", "AVAILABILITY", "AVALANCHE", "AWAKENING", "AWARDING", "AWKWARDLY", "AXIOMATIC", "BABYPROOF", "BACCHANALIA", "BACCHANALIAN", "BACKBOARD", "BACKDOOR", "BACKFILL", "BACKHAND", "BACKING", "BACKLIT", "BACKLOG", "BACKROOM", "BACKWARD", "BACKYARD", "BAILIWICK", "BALCONY", "BALDING", "BALLETIC", "BAMBOOZLE", "BANALITY", "BANDWAGON", "BAPTIZE", "BATHING", "BATHROOM", "BEACHCOMB", "BEANPOLE", "BEATIFIC", "BEDFELLOW", "BEEKEEPING", "BELATEDLY", "BELITTLEMENT", "BELITTLING", "BELLYACHE", "BELTING", "BEMOANED", "BENEFICENT", "BENEFITED", "BENEFITTED", "BENEVOLENCE", "BENEVOLENT", "BETIDING", "BEWITCH", "BIGHEAD", "BIGHEADED", "BIGOTED", "BIGOTRY", "BILINGUAL", "BILLBOARD", "BILLETING", "BILLIONTH", "BILLOWING", "BIOLOGICAL", "BIOTECH", "BIPLANE", "BIRDBATH", "BLACKEN", "BLACKMAIL", "BLADING", "BLANKED", "BLANKET", "BLINDFOLD", "BLINTZE", "BLITHELY", "BLIZZARD", "BLOCKABLE", "BLOCKED", "BLOODBATH", "BLOODHOUND", "BLOWBACK", "BLOWING", "BLOWPIPE", "BLUEFIN", "BLURRING", "BOATYARD", "BOGEYING", "BOGEYMEN", "BOGLAND", "BOOKMOBILE", "BOOTJACK", "BORROWING", "BOTTLEFUL", "BOWLING", "BOYCOTTED", "BRANCHY", "BRAVING", "BRAYING", "BRICKBAT", "BRICKWORK", "BRILLIANT", "BRIMFUL", "BROADLY", "BRONZING", "BROUGHT", "BROWNING", "BROWNOUT", "BUCKTOOTH", "BULLETIN", "BULLFROG", "BULLRING", "BULLYRAG", "BULWARK", "BUOYANT", "BURBLING", "BURGLARY", "BURGLING", "BURPING", "BUTTONED", "BUTTONING", "BUZZWORD", "CABOODLE", "CACKLING", "CACOPHONY", "CALAMITY", "CALCULATOR", "CALORIFIC", "CAMELBACK", "CAMPAIGN", "CAMPAIGNING", "CAMPING", "CANCELING", "CANCELLING", "CANONICALLY", "CANONIZATION", "CAPACITANCE", "CAPACITOR", "CAPELLINI", "CAPITOL", "CAPTAINCY", "CAPTIVATE", "CAPTIVE", "CAPTIVITY", "CARDIGAN", "CARDING", "CARNIVAL", "CAROTID", "CARPING", "CARRYING", "CARRYOUT", "CARTFUL", "CARTLOAD", "CATALYZE", "CATCHMENT", "CATHOLIC", "CELIBACY", "CELIBATE", "CENTUPLE", "CHAIRMAN", "CHALKED", "CHALLENGE", "CHANGED", "CHANNELED", "CHANTEY", "CHAPPING", "CHARGRILL", "CHARITY", "CHATROOM", "CHECKABLE", "CHECKMATE", "CHEEKBONE", "CHEMICAL", "CHEWABLE", "CHEWING", "CHICKADEE", "CHIEFLY", "CHILDLIKE", "CHIMICHANGA", "CHIMNEY", "CHINTZY", "CHIVALRIC", "CHLOROFORM", "CHLOROPHYLL", "CHOCOLATE", "CHOIRBOY", "CHOIRGIRL", "CHOPPING", "CHUCKING", "CHUNKED", "CHUNKING", "CHURCHYARD", "CHUTNEY", "CHUTZPAH", "CINEPHILE", "CITABLE", "CLACKING", "CLAIMABLE", "CLAIMANT", "CLAMBAKE", "CLANGED", "CLANKING", "CLARIFY", "CLAWING", "CLEANING", "CLEMENTINE", "CLENCHING", "CLICKABLE", "CLICKBAIT", "CLIMACTICALLY", "CLIMATE", "CLIMATICALLY", "CLIMBABLE", "CLIPPABLE", "CLOAKED", "CLOAKROOM", "CLOTBUR", "CLOWNED", "CLUNKED", "CLUTCHED", "COAUTHOR", "COCKTAIL", "CODABLE", "COEFFICIENT", "COFFINED", "COFOUNDED", "COGWHEEL", "COLLABORATOR", "COLLECTIBLE", "COLLECTIVE", "COLONIALLY", "COLORANT", "COLORATURA", "COLORFULLY", "COMBATANT", "COMICALLY", "COMMITMENT", "COMMITTED", "COMMITTEEMEN", "COMMODIFY", "COMMODITY", "COMPANION", "COMPANY", "COMPETED", "COMPETENCE", "COMPETENT", "COMPONENT", "COMPOUND", "CONCEIVED", "CONCLUDE", "CONCLUDED", "CONCORDANT", "CONDITIONING", "CONDOMINIUM", "CONDONATION", "CONDUCTED", "CONDUCTION", "CONDUCTOR", "CONDUIT", "CONFECTION", "CONFETTI", "CONFIDE", "CONFIDED", "CONFIDENCE", "CONFINED", "CONFIRM", "CONFLICT", "CONFLUENCE", "CONFOUNDED", "CONGAED", "CONICALLY", "CONIFORM", "CONJOINED", "CONNECTIVE", "CONNIVED", "CONTEMPT", "CONTENTLY", "CONTINUITY", "CONTINUUM", "CONTRALTO", "CONUNDRUM", "CONVECTION", "CONVECTIVE", "CONVENIENT", "CONVENTION", "CONVEYED", "CONVINCED", "CONVIVIAL", "CONVOYED", "COOKABLE", "CORDIAL", "CORKBOARD", "CORNBALL", "CORNILY", "COTTONMOUTH", "COUCHING", "COUGHING", "COUNCILOR", "COUNTDOWN", "COUNTED", "COUNTRY", "COUPLED", "COVENANT", "COWGIRL", "COWHAND", "CRACKPOT", "CRAPPING", "CRAZILY", "CRIMINAL", "CRINKLY", "CRUCIFORM", "CUFFLINK", "CULPRIT", "CULLY", "CULTURALLY", "CURTAIN", "CUTDOWN", "CUTTHROAT", "CYANIDE", "DABBLING", "DAINTILY", "DAMNATION", "DANCEHALL", "DATAFLOW", "DAUNTING", "DAYTIME", "DAYWORK", "DAZZLING", "DEADLOCK", "DEADLOCKED", "DEAFENING", "DEATHLY", "DEBATABLY", "DEBITING", "DECAGON", "DECOMMIT", "DECOMMITTED", "DECOUPLE", "DECOUPLED", "DEDUCTIVE", "DEFANGING", "DEFAULT", "DEFAULTED", "DEFICIENT", "DEFINITIVE", "DEFOGGING", "DEFYING", "DEHUMIDIFIED", "DEIFYING", "DELIGHT", "DELIGHTED", "DEMONIZE", "DEMONIZED", "DENOUEMENT", "DEPENDENTLY", "DEPUTIZE", "DEPUTIZED", "DETOXIFIED", "DEVIANCE", "DEVIANT", "DEVOTION", "DIABETIC", "DIABOLIC", "DIABOLICAL", "DIACRITICAL", "DIATOMIC", "DIATONIC", "DICTATION", "DICTATOR", "DIFFICULT", "DIFFRACT", "DIGITALLY", "DILATION", "DIRTBAG", "DIVEBOMB", "DIVEBOMBED", "DIVULGING", "DOCILITY", "DOCKYARD", "DOCTORAL", "DODECAGON", "DOGFIGHT", "DOLEFULLY", "DOLPHIN", "DOMICILE", "DOMICILED", "DOMINANT", "DOMINATION", "DONATING", "DONNYBROOK", "DOORJAMB", "DOORNAIL", "DORMANT", "DORMITORY", "DOUBTFUL", "DOUGHBOY", "DOUGHNUT", "DOWNHILL", "DOWNLOADED", "DOWNPOUR", "DOWNTURN", "DRACONIAN", "DRACONIC", "DRAMATIC", "DRAPING", "DRAWBACK", "DRAWING", "DRIFTWOOD", "DROOPING", "DROPKICK", "DROPPING", "DROUGHT", "DUCTILITY", "DUMBFOUND", "DUTIFULLY", "DYNAMIC", "EBULLIENT", "EDIFYING", "EFFACING", "EFFECTING", "EFFECTUAL", "EGGPLANT", "EJECTABLE", "EJECTION", "ELECTING", "ELEGANCY", "ELEMENTALLY", "ELEPHANT", "ELICITING", "ELIGIBILITY", "EMBANKED", "EMBANKMENT", "EMBEZZLEMENT", "EMBOLDEN", "EMBOLDENED", "EMINENTLY", "EMOLUMENT", "EMOTICON", "EMOTIVITY", "EMPATHY", "ENCAMPMENT", "ENCHAINING", "ENCHANTMENT", "ENGULFED", "ENGULFING", "ENHANCEMENT", "ENHANCING", "ENJOYMENT", "ENLACING", "ENLIGHTEN", "ENLIGHTENING", "ENNOBLEMENT", "ENTANGLEMENT", "ENTOMBED", "ENVELOPED", "ENVIABLE", "EPIPHANY", "ETHANOL", "ETHICAL", "ETHNICITY", "ETHOLOGY", "ETYMOLOGY", "EVENTFUL", "EVICTION", "EVOKING", "EXACTABLE", "EXCAVATED", "EXCELLENTLY", "EXCELLING", "EXCHANGE", "EXCITEMENT", "EXCITING", "EXECUTANT", "EXPECTANT", "EXPENDING", "EXPLETIVE", "EXPLICIT", "EXPOUND", "EXPOUNDED", "EXPUNGING", "EXTENUATED", "EXTINCTION", "EXTOLMENT", "EXULTANT", "FACELIFT", "FACEPLATE", "FACILITATE", "FACILITY", "FACTORY", "FACTOTUM", "FACTUALLY", "FACULTY", "FAINTLY", "FAMILIARLY", "FANCIFUL", "FANCILY", "FARCICALLY", "FARMHAND", "FARMING", "FARMLAND", "FAULTED", "FELICITY", "FEMININITY", "FETTUCCINE", "FIDGETY", "FILCHING", "FILENAME", "FINALITY", "FINANCIALLY", "FINITUDE", "FIVEFOLD", "FIXABLE", "FIXATED", "FIXATION", "FLAGPOLE", "FLAGRANT", "FLAKING", "FLANKING", "FLAPJACK", "FLATBED", "FLATLINE", "FLATULENT", "FLAVORFUL", "FLEXIBLY", "FLEXION", "FLEXITIME", "FLEXTIME", "FLIGHTY", "FLINCHING", "FLIPBOOK", "FLIPFLOPPED", "FLIPFLOPPING", "FLIPPANT", "FLOODING", "FLOORBOARD", "FLOPPING", "FLOUNCE", "FLOWING", "FLUCTUANT", "FLUCTUATE", "FLUENCY", "FLUENTLY", "FLUIDITY", "FOLDING", "FOLLOWING", "FONDLING", "FOOTBOARD", "FOOTPRINT", "FORAGING", "FORKLIFT", "FORMALLY", "FORMANT", "FORMULA", "FORTHRIGHT", "FORTHWITH", "FOUNDRY", "FOXGLOVE", "FRAILTY", "FRAMING", "FRANKLY", "FRANTIC", "FRAUGHT", "FRICTION", "FRONTAL", "FRONTMAN", "FRUGALLY", "FRUITION", "FUELING", "FULLBACK", "FUNCTION", "FUNNELING", "FURLONG", "FURLOUGH", "GALLANTRY", "GALUMPH", "GAMECOCK", "GAMEPLAY", "GARBANZO", "GAZILLION", "GAZPACHO", "GENEALOGY", "GENOTYPE", "GENTLEMAN", "GIMCRACK", "GIRLHOOD", "GLAMOUR", "GLANCED", "GLANDULAR", "GLITCHING", "GLITCHY", "GLORIFY", "GLUTTONY", "GLYCOGEN", "GODCHILD", "GOODNIGHT", "GRADUALLY", "GRANDBABY", "GRANDPOP", "GRAPHIC", "GRAPHING", "GRATIFY", "GRAVITY", "GROUCHY", "GROUNDHOG", "GROWNUP", "GRUMPING", "GUARANTOR", "GUFFAWING", "GUILTED", "GULLIBILITY", "GUMDROP", "GUNPORT", "GYNECOLOGY", "GYRATING", "HABITUAL", "HACKABLE", "HACKNEY", "HAGGARDLY", "HAIRBAND", "HAIRCUT", "HALCYON", "HALFWIT", "HALIBUT", "HALOGEN", "HANDBILL", "HANDBOOK", "HANDCLAP", "HANDFUL", "HANDICAP", "HANDILY", "HANDLING", "HANDOUT", "HANDRAIL", "HAPPENING", "HARDBACK", "HARDTACK", "HARDTOP", "HARMONY", "HARPING", "HATEFUL", "HAULING", "HAUNTED", "HAWTHORN", "HAYFORK", "HAYLOFT", "HEADHUNT", "HEADHUNTED", "HEADLAMP", "HEADPHONE", "HEADPIECE", "HEADPIN", "HEADWIND", "HEALTHFUL", "HEAPING", "HEATEDLY", "HEAVENLY", "HEAVILY", "HEGEMONY", "HELIPAD", "HEMATIC", "HEMLOCK", "HICCOUGHING", "HICCUPED", "HICKORY", "HIGHLAND", "HIGHLIGHTED", "HILARITY", "HINDBRAIN", "HIPPOGRIFF", "HOLIDAY", "HOLLOWING", "HOLOGRAM", "HOMEPAGE", "HOMETOWN", "HOMOGENY", "HOMOGRAPH", "HOMOPHONIC", "HONEYBUN", "HONEYDEW", "HONEYPOT", "HONORIFIC", "HOODWINK", "HORMONAL", "HOROLOGIC", "HORRIBLY", "HOTDOGGING", "HOTLINE", "HOURLONG", "HOWLING", "HUMANLY", "HUMBLE", "HUMIDIFIED", "HYACINTH", "HYDRANT", "HYDROLOGY", "HYMNBOOK", "HYPHENATE", "ICONICALLY", "IDEOLOGY", "IDIOMATIC", "ILLEGALITY", "ILLEGIBILITY", "ILLIQUIDITY", "IMBROGLIO", "IMMATURITY", "IMMEDIACY", "IMMIGRANT", "IMMIGRATING", "IMMINENTLY", "IMMOBILITY", "IMMOBILIZE", "IMMORTAL", "IMMUNIZED", "IMPALPABLE", "IMPARTIAL", "IMPATIENT", "IMPEDIMENT", "IMPLANT", "IMPLEMENT", "IMPLICITLY", "IMPOLITIC", "IMPOTENT", "IMPURITY", "IMPUTED", "IMPUTING", "INABILITY", "INACTIVATE", "INACTIVEM", "INACTIVITY", "INAUGURAL", "INCAPACITATE", "INCAPACITY", "INCENTIVIZE", "INCEPTIVE", "INCIVILITY", "INCLEMENCY", "INCLEMENT", "INCLUDE", "INCLUDEDA", "INCONVENIENCED", "INCONVENIENT", "INDICATION", "INDIGNATION", "INDIVIDUAL", "INDUCTED", "INDUCTEEO", "INDUCTION", "INEFFABLE", "INEFFECTIVE", "INELEGANCE", "INEPTLY", "INEXACT", "INFALLIBLE", "INFANTILE", "INFANTILITY", "INFANTRY", "INFECTED", "INFECTING", "INFECTION", "INFECTIVE", "INFINITUDE", "INFIRMARY", "INFLAME", "INFLATE", "INFLECT", "INFLEXIBLE", "INFLICTION", "INGENUITY", "INHABITING", "INHALATION", "INHIBITIVE", "INHIBITOR", "INIMICALLY", "INITIALIZE", "INJECTED", "INJECTION", "INKBLOT", "INNOVATING", "INTACTLY", "INTELLIGENCE", "INTELLIGIBLE", "INTIMACY", "INTIMIDATION", "INTRADAY", "INTRICACY", "INUNDATING", "INVALIDLY", "INVINCIBLE", "INVOICED", "ITALICIZE", "ITEMIZING", "JACKBOOT", "JACKPOT", "JAILBIRD", "JANITOR", "JAVELIN", "JAVELINAA", "JAWBONE", "JAYBIRD", "JOCULAR", "JOINTED", "JOUNCING", "JOURNAL", "JUDICIAL", "JUVENILE", "KETCHUP", "KITCHEN", "KITCHENETTE", "KNEADABLE", "KNEADING", "KNOTHOLE", "KNUCKLED", "KRYPTON", "LABORATORY", "LACKING", "LACONICALLY", "LADYBUG", "LANDMARK", "LAPBOARD", "LAPIDARY", "LATITUDINAL", "LAUGHED", "LAUGHING", "LAUNDRY", "LAVATORY", "LAYWOMAN", "LEECHING", "LEGALITY", "LEGALIZED", "LEGIBILITY", "LEGITIMIZE", "LEITMOTIF", "LENGTHENED", "LENGTHENING", "LENGTHY", "LETDOWN", "LEVITATED", "LEXICON", "LIFEBLOOD", "LIFELONG", "LIGHTBULB", "LIGHTED", "LIGHTEN", "LIGHTENING", "LIGHTWEIGHT", "LIKELIHOOD", "LIMELIGHT", "LINOCUT", "LIQUIDITY", "LITIGATOR", "LITURGY", "LIVABILITY", "LOCKABLE", "LOCOMOTION", "LOCUTION", "LOGOPHILE", "LOGOTYPE", "LOLLYGAGGED", "LOLLYGAGGING", "LONGBOAT", "LONGHAND", "LONGNECK", "LOUDMOUTH", "LOVEABLY", "LOWLIGHT", "LUCIDITY", "LUNATIC", "LUNCHED", "LUNCHEON", "MACHINE", "MACHINING", "MADRIGAL", "MAGAZINE", "MAHOGANY", "MAILBOX", "MAJORLY", "MALEFIC", "MANAGEABLE", "MANDATOR", "MANDOLIN", "MANIACALLY", "MANICALLY", "MARATHON", "MARIJUANA", "MARINATING", "MARITALLY", "MARTIALLY", "MARTYRDOM", "MARZIPAN", "MATCHMAKE", "MATCHUP", "MATHEMATIC", "MATRIARCH", "MATURITY", "MAYPOLE", "MEATLOAF", "MECHANIC", "MEDIEVAL", "MEDITATIVE", "MEGABIT", "MEGABYTE", "MEGAHIT", "MEGAPLEX", "MELODIC", "MENACING", "MENFOLK", "MENTALLY", "MENTHOL", "MEOWING", "METALHEAD", "METALLIC", "MEZZOTINT", "MICROCOPY", "MICROFILM", "MIDBRAIN", "MIDMONTH", "MIDPOINT", "MIDTOWN", "MIGHTILY", "MIGRANT", "MIGRATING", "MILITARILY", "MILITARY", "MILLIONTH", "MINDFUL", "MINORITY", "MIXOLOGY", "MOBILITY", "MOBILIZE", "MODULAR", "MOLLYCODDLE", "MOLLYCODDLED", "MONARCH", "MONETIZE", "MONITORY", "MONOCRACY", "MONOLITH", "MONOPHONIC", "MONOXIDE", "MONTHLONG", "MONTHLY", "MOOCHING", "MOONWALK", "MORDANT", "MORTARBOARD", "MORTIFY", "MOTHBALL", "MOTIVATION", "MOTORCOACH", "MOTORWAY", "MOUNTED", "MOURNFUL", "MOURNING", "MOUTHED", "MOUTHFUL", "MOVABLY", "MUDFLAP", "MUDFLATA", "MULTILEVEL", "MULTIMILLION", "MULTIPLY", "MUNCHKIN", "MUTABLE", "MUZZLING", "MYTHOLOGY", "NAIVELY", "NAMECHECK", "NAMEPLATE", "NARROWLY", "NATIONHOOD", "NATURALLY", "NAUGHTY", "NAUTICAL", "NAVIGATION", "NEGLECTING", "NEOLITH", "NEOPHYTE", "NICKNAMING", "NIGHTTIME", "NITPICKY", "NOBILITY", "NOBLEWOMEN", "NOMADIC", "NONALCOHOLIC", "NONAPOLOGY", "NONBELIEF", "NONCOMBATANT", "NONCOMPETE", "NONCONDUCTOR", "NONDAIRY", "NONDOMINANT", "NONDORMANT", "NONEXEMPT", "NONLETHAL", "NONPROFIT", "NONVIOLENT", "NORMALLY", "NOTABLY", "OBEDIENCE", "OBEYING", "OBJECTED", "OBLIGED", "OCCIPITAL", "OCCUPANT", "OFFENDING", "OFFHANDED", "OFFICIALLY", "OFFPRINT", "OFFTRACK", "OMNIPOTENT", "OPENABLE", "OPENHANDED", "OPTICAL", "OPTIMAL", "OPULENT", "ORANGUTAN", "ORDINAL", "ORDINARY", "ORGANIZING", "ORPHANHOOD", "ORTHODOXY", "OUTBACK", "OUTBOARD", "OUTFOXED", "OUTGROWN", "OUTGROWTH", "OXIDANT", "OXIDATION", "OXIDIZING", "PACKABLE", "PADLOCK", "PAGEBOY", "PAINFUL", "PAINKILLING", "PAINTBALL", "PANHANDLE", "PANHANDLED", "PANTHEON", "PARADIGM", "PARADING", "PARAGRAPHING", "PARANOID", "PARANORMAL", "PARKING", "PARKLAND", "PARTICIPANT", "PATENTABLE", "PATENTLY", "PATIENCE", "PATRICIAN", "PATRIOTIC", "PAUNCHY", "PAVEMENT", "PAVILION", "PAYCHECK", "PAYMENT", "PAYPHONE", "PEAFOWL", "PEAKING", "PEDAGOGY", "PELICAN", "PENALTY", "PENDULUM", "PENITENTLY", "PENTACLE", "PENTATHLETE", "PENTIMENTO", "PETTIFOG", "PHABLET", "PHANTOM", "PHARMACY", "PHENOMENA", "PHENOTYPE", "PHILHELLENIC", "PHILOLOGY", "PHOENIX", "PHONOGRAPH", "PHOTOCELL", "PHOTOGRAPH", "PICANTE", "PICNICKED", "PIMENTO", "PIMIENTO", "PINCHPENNY", "PINEWOOD", "PINHEAD", "PINHEADED", "PINNACLE", "PINWHEEL", "PITCHED", "PITCHING", "PITTANCE", "PITUITARY", "PITYINGLY", "PIVOTED", "PIVOTING", "PLACEBO", "PLACENTAA", "PLACENTAL", "PLAINTIFF", "PLANGENT", "PLANKING", "PLANKTON", "PLANTABLE", "PLATEFUL", "PLAUDIT", "PLAYBOOK", "PLEBEIAN", "PLIANTLY", "PLOWABLE", "POCKETBOOK", "POCKMARK", "POLEMIC", "POLITICAL", "POLYGAMY", "POLYGONAL", "POMPADOUR", "POOCHING", "PORTFOLIO", "POTABLE", "POTBELLY", "POTENCY", "POTENTLY", "POTHEAD", "POTLATCH", "POTLUCK", "POULTRY", "PRACTICIAN", "PRANCING", "PRANKING", "PRICKLY", "PRIMALLY", "PRIMARILY", "PRINCIPAL", "PRIVACY", "PROBIOTIC", "PROBITY", "PRODDING", "PRODIGY", "PRODUCT", "PROHIBIT", "PROHIBITOR", "PROMONTORY", "PROMOTION", "PROMPTLY", "PROPAGANDA", "PROUDLY", "PUBLICLY", "PULLBACK", "PUNGENCY", "PURLOIN", "PUTDOWN", "PYRAMID", "QUADRANT", "QUANDARY", "QUIETING", "QUOTING", "RABBINICAL", "RADICALLY", "RAINBOW", "RAINDROP", "RAMBUTAN", "RAPACITY", "RAPIDITY", "RAPIDLY", "RAUNCHY", "RAZORBACK", "RAZORING", "RHOMBOID", "RIGHTLY", "ROCKFALL", "ROLLBACK", "ROTUNDA", "ROWDILY", "RUMORING", "TABLETOP", "TACITURN", "TACKING", "TACKLED", "TACTFULLY", "TAILBACK", "TAILWIND", "TALKATIVE", "TAMARIND", "TANTALIZE", "TARRYING", "TAXABILITY", "TAXONOMY", "TELEGENIC", "TELEKINETIC", "TELEPATHY", "TENACITY", "THEMATIC", "THEMING", "THEOLOGY", "THICKEN", "THIMBLE", "THIRDHAND", "THOUGHTFUL", "THRILLING", "THROWAWAY", "THRUWAY", "THYROID", "TIGHTWAD", "TITANICALLY", "TOMAHAWK", "TOOTHPICK", "TOPIARY", "TOPICAL", "TOUCHED", "TOUGHEN", "TOUGHLY", "TOWLINE", "TOWNHOME", "TOXIFIED", "TRACHOMA", "TRACKPAD", "TRACKWAY", "TRAGICAL", "TRAUMATIC", "TRAYFUL", "TRIBUTARY", "TRILLIONTH", "TRIPTYCH", "TRIVIALITY", "TRIVIALLY", "TROUBADOUR", "TRUANCY", "TUNEFULLY", "TURNAROUND", "TURNCOAT", "TURNDOWN", "TWINKLE", "TWINKLY", "TWITCHED", "TWITCHING", "TYPEFACE", "UMPIRING", "UMPTEENTH", "UNBELIEF", "UNBLOCK", "UNBOXING", "UNBUCKLE", "UNBUTTONED", "UNBUTTONING", "UNCARING", "UNCHECKED", "UNCLENCHED", "UNCLOAK", "UNCLOGGING", "UNCOILING", "UNCOMMONLY", "UNCONNECTED", "UNCONVINCING", "UNCOUNTED", "UNDOUBTED", "UNEQUALED", "UNEVENTFUL", "UNEVOLVED", "UNFEELING", "UNFITTED", "UNFLEDGED", "UNFRUITFUL", "UNGODLY", "UNHEATED", "UNHELPFUL", "UNHUMANLY", "UNICOLOR", "UNIDENTIFIED", "UNINVITED", "UNJAMMING", "UNKEMPT", "UNKINDLY", "UNKNOWING", "UNLATCH", "UNLOVED", "UNLOVELY", "UNMINDFUL", "UNMOORING", "UNMOUNTED", "UNMUZZLING", "UNNATURALLY", "UNPOPULAR", "UNTACTFUL", "UNTAGGED", "UNTAXED", "UNTUCKED", "UNVEILING", "UNZIPPED", "UPBRINGING", "UPDRAFT", "UPHEAVAL", "VACANTLY", "VACCINATE", "VAGABOND", "VAGUELY", "VALENTINE", "VALIDATE", "VALIDATED", "VALIDITY", "VANGUARD", "VAPIDLY", "VARMINT", "VEGETABLE", "VENGEFUL", "VENIALLY", "VENTILATE", "VIABILITY", "VIADUCT", "VIBRANT", "VIBRATO", "VIBRATOR", "VICTIMIZE", "VICTORY", "VILIFYING", "VINCIBLE", "VINDICTIVE", "VIOLENT", "VIRALITY", "VIRTUAL", "VITRIOLIC", "VOLATILITY", "VOLCANIC", "VOLLEYBALL", "VOLTAGEM", "VULGARLY", "VULPINE", "WAKENING", "WALKOUT", "WARDING", "WARLOCK", "WARMING", "WARPING", "WARTHOG", "WATCHMAN", "WEAKENING", "WEALTHY", "WEAVING", "WEDLOCK", "WEEKLONG", "WEIGHTED", "WEIGHTY", "WHEELING", "WHEEZING", "WHIPPOORWILL", "WHIRLPOOL", "WHOOPING", "WHOPPING", "WHUPPING", "WILDCARD", "WILDCAT", "WINDBLOWN", "WINDFALL", "WINDMILLED", "WITCHING", "WITHDRAW", "WITHHOLD", "WIZARDRY", "WOBBLING", "WOLFING", "WOMANHOOD", "WOMANLY", "WORDILY", "WORKADAY", "WORKDAY", "WORKLOAD", "WRAPPING", "WRINKLY", "WROUGHT", "XENOPHOBE", "YARDWORK", "YOUTHFUL", "YOUTHFULLY", "ZIRCONIA", "ZOOLOGICAL"]
    
   
    init() {
        currentStat = Statistic.loadStat()
    }
    
    func getWord() -> [String] {
        
        chosenPangram = possibleWords.randomElement()!
        playedWords.append(chosenPangram)
        possibleWords.remove(at: possibleWords.firstIndex(of: chosenPangram) ?? 0)
        
//        if currentStat.gamesPlayed >= possibleWords.count + playedWords.count {
//            chosenPangram = possibleWords.randomElement()!
//            playedWords.append(chosenPangram)
//            possibleWords.remove(at: possibleWords.firstIndex(of: chosenPangram) ?? 0)
//        } else {
//            chosenPangram = playedWords.randomElement()!
//            possibleWords.append(chosenPangram)
//            playedWords.remove(at: playedWords.firstIndex(of: chosenPangram) ?? 0)
//        }
        
        pangramList = []
        for char in chosenPangram {
            pangramList.append(String(char))
        }
                
        var chosenLetters = Array(Set(pangramList))
        
        if let index = chosenLetters.firstIndex(of: "A") {
            chosenLetters.insert(chosenLetters.remove(at: index), at: 0)
        } else if let index = chosenLetters.firstIndex(of: "E") {
            chosenLetters.insert(chosenLetters.remove(at: index), at: 0)
        } else if let index = chosenLetters.firstIndex(of: "I") {
            chosenLetters.insert(chosenLetters.remove(at: index), at: 0)
        } else if let index = chosenLetters.firstIndex(of: "O") {
            chosenLetters.insert(chosenLetters.remove(at: index), at: 0)
        } else if let index = chosenLetters.firstIndex(of: "U") {
            chosenLetters.insert(chosenLetters.remove(at: index), at: 0)
        } else if let index = chosenLetters.firstIndex(of: "Y") {
            chosenLetters.insert(chosenLetters.remove(at: index), at: 0)
        }
        
        return chosenLetters
    }
    
    func newGame() {
        lettersChosen = getWord()
        
        letterCenter = lettersChosen[0]
        lettersOther = [lettersChosen[1], lettersChosen[2], lettersChosen[3], lettersChosen[4], lettersChosen[5], lettersChosen[6]]
        lettersOther.shuffle()
        currentWord = ""
        wordsFound = [String]()
        pointsReceived = 0
        mistakeCounter = 0
        hintChars = "\(pangramList[0])\(pangramList[1])\(pangramList[2])..."
        
        gameOver = false
        showHint = false
        showLevels = false
        timePause = false
        
        onScreen = viewMode.GAME
    }
    
    func enterWord(word: String) {
        newWord = true
        showHint = false
        
        if !isError() {
            errorFound = false
            pointsReceived += returnPoints()
            timeRemaining += returnPoints()
            wordsFound.append(currentWord)
        } else {
            mistakeCounter += 1
            errorFound = true
        }
        
        if limitMistakesOn {
            if mistakeCounter == 3 {
                gameOver = true
            }
        }
        currentWord = ""
    }
    
    func shuffleLetters() {
        lettersOther.shuffle()
    }
    
    func addToCurrentWord(_ letter: String) {
        currentWord += letter
    }
    
    func minuteTimer() -> String {
        let seconds = timeRemaining % 60
        let minutes = timeRemaining / 60
        
        if seconds >= 10 {
            return "\(minutes):\(seconds)"
        } else {
            return "\(minutes):0\(seconds)"
        }
    }
    
    func gameEnd() {
        currentStat.update(pointsReceived: pointsReceived, wordCount: wordsFound.count, timePlayed: timePlayed)
    }
    
    func isPangram(word: String) -> Bool {
        return word.contains(lettersChosen[0]) && word.contains(lettersChosen[1]) && word.contains(lettersChosen[2]) && word.contains(lettersChosen[3]) && word.contains(lettersChosen[4]) && word.contains(lettersChosen[5]) && word.contains(lettersChosen[6])
    }
    
    func returnPoints() -> Int {
        if isPangram(word: currentWord) {
            return currentWord.count + 7
        } else if currentWord.count == 4 {
            return 1
        } else {
            return currentWord.count
        }
    }
    
    func returnCompliment() -> String {
        if isPangram(word: currentWord) {
            return "Pangram!"
        } else if currentWord.count == 4 {
            return "Nice!"
        } else if currentWord.count < 7 {
            return "Great!"
        } else {
            return "Excellent!"
        }
    }
    
    // ERROR MESSAGE
    
    func checkExcess() -> Bool {
        let enteredList = Array(currentWord)
        var invalid = false
        for item in enteredList {
            if !(lettersOther + [letterCenter]).contains(String(item)) {
                invalid = true
                break
            }
        }
        return invalid
    }
    
    func checkExists() -> Bool {
            let textChecker = UITextChecker()
            let range = NSRange(location: 0, length: currentWord.utf16.count)
            
            let misspelledRange = textChecker.rangeOfMisspelledWord(
                in: currentWord.lowercased(),
                range: range,
                startingAt: 0,
                wrap: false,
                language: "en"
            )
            
            return misspelledRange.location == NSNotFound
        }
    
    func getErrorMessage() -> String {
        
        if currentWord.count > 20 {
            return "Too long"
        } else if wordsFound.contains(currentWord) {
            return "Already found"
        } else if currentWord.count < 4 {
            return "Too short"
        } else if !(currentWord.contains(letterCenter)) { // if the middle letter is missing
            return "Missing middle letter"
        } else if checkExcess() { // if the word has excess letters
            return "Includes excess letters"
        } else if !checkExists() || currentWord == "\(letterCenter)\(letterCenter)\(letterCenter)\(letterCenter)" {
            return "Not in word list"
        } else {
            return "None"
        }
    }
    
    func isError() -> Bool {
        return getErrorMessage() != "None"
    }
    
}
