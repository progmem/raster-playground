class Level
  module ChemicalPlantBg
    extend Level::BackdropBuilder
    extend self

    @@tile_width  = 16
    @@tile_height = 16
    @@tileset     = "res/levels/chemical_plant_bg.png"
    @@palette     = "res/levels/chemical_plant_bg.pal.png"
    @@width       = 48
    @@map         = [
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    1,    0,    2,    0,    0,    0,    0, 
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    1,    0,    2,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    3,    0,    0,    0,    0,    0,    0, 
         0,    0,    0,    0,    0,    1,    0,    2,    0,    0,    0,    0,    1,    0,    2,    0,    3,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    1,    0,    2,    0,    0,    0,    0,    0,    0,    4,    5,    6,    0,    0,    0,    0, 
         0,    0,    0,    0,    0,    3,    0,    0,    0,    0,    0,    0,    7,    8,    8,    0,    4,    5,    6,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    7,    8,    8,    0,    0,    0,    0,    0,    0,    4,    5,    6,    0,    0,    0,    0, 
         0,    0,    0,    0,    0,    4,    5,    6,    0,    0,    0,    0,    9,   10,   10,    0,   11,   12,   13,    1,    0,    0,    2,    0,    0,    0,    0,    0,    0,    0,    0,    0,    9,   10,   10,    0,    0,    0,    0,    0,    0,   11,   12,   13,    0,    0,    0,    0, 
         0,    0,    0,    0,    0,   11,   12,   13,    0,   14,   14,   14,   15,   10,   16,    0,   17,   18,   19,    7,    8,    0,    8,    0,    1,    2,    0,    0,    0,    0,    0,    0,   15,   10,   16,    0,    0,    0,    0,    0,   20,   17,   18,   19,    0,    0,    0,    0, 
         0,    0,    1,   21,    0,   17,   18,   19,    0,   14,   14,   14,   22,   23,   24,    0,   25,   26,   27,   15,   23,   16,   24,    0,   28,   29,    0,    0,    0,    0,    0,    0,   22,   23,   24,    1,    0,    0,    2,    0,   30,   25,   26,   27,    0,    0,    0,    0, 
         0,    0,   31,   14,   14,   25,   26,   27,    0,   14,   14,   14,   22,   32,   33,   34,   35,   36,   37,   22,   38,   33,   32,   39,   40,   41,   40,   42,    0,    0,   14,   14,   22,   32,   33,    7,    8,    0,    8,    0,   34,   35,   36,   37,    0,    2,    0,   34, 
        43,   44,   44,   44,   14,   45,   46,   47,    0,   14,   14,   14,   48,   49,   38,   20,   45,   46,   47,   48,   49,   38,   50,   51,   52,   52,   52,   53,    0,    0,   14,   14,   48,   49,   38,   15,   23,   16,   24,    0,   20,   45,   46,   47,   10,   24,    0,   20, 
        54,   55,   55,   56,   14,   45,   47,   47,    0,   14,   14,   14,   57,   58,   59,   30,   45,   47,   46,   57,   60,   61,   62,   63,   64,   64,   64,   65,    0,    0,   14,   14,   57,   58,   59,   22,   58,   33,   61,   62,   30,   45,   47,   46,   23,   24,    0,   30, 
        63,   66,   64,   65,   14,   45,   47,   47,   67,   68,   14,   14,   69,   70,   71,   72,   45,   47,   46,   69,   71,   61,   62,   73,   74,   74,   74,   75,   76,   77,   78,   14,   69,   70,   71,   69,   70,   38,   79,   80,   72,   45,   47,   46,   49,   38,    0,   72, 
        73,   66,   74,   65,   14,   81,   82,   83,   67,   84,   85,   76,   77,   78,   86,   87,   81,   88,   89,   69,   70,   79,   80,   63,   90,   90,   67,   68,   68,   91,   92,   88,   89,   86,   86,   69,   86,   86,   61,   62,   87,   81,   82,   83,   85,   76,   77,   78, 
        63,   66,   93,   67,   68,   68,   61,   62,   67,   84,   94,   95,   91,   92,   68,   68,   68,   88,   89,   69,   86,   61,   62,   73,   90,   90,   67,   84,   84,   96,   97,   88,   98,   68,   68,   68,   88,   89,   79,   80,   67,   68,   68,   68,   94,   95,   91,   92, 
        63,   83,   82,   88,   89,   84,   79,   80,   67,   84,   94,   99,   96,   97,   84,   84,   84,   88,   89,   76,   77,   78,   80,   63,   93,   93,   67,   84,   84,  100,  101,   88,   89,   84,   84,   84,   88,   89,   61,   62,   88,   89,   84,   84,   94,   99,   96,   97, 
       102,  103,  104,   88,   89,  105,  105,  105,  102,  103,  104,  106,  100,  101,  105,  102,  103,  104,  104,  104,  100,  101,   62,  102,  104,  104,  104,  105,  102,  104,  104,  104,   89,  104,  104,  105,  102,  104,  104,  104,   88,   89,  105,  102,  104,  106,  100,  101, 
       107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108,  107,  108, 
       109,  109,  110,  111,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  112,  112,  113,  114,  109,  109,  109,  109, 
       109,  109,  110,  111,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  112,  112,  113,  114,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,    0,    0,  115,  116,  109,  109,  109,  109, 
       109,  109,  110,  111,  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,    0,    0,  115,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,  112,  113,  114,  109,  109,  109,  109,  109,  109,  109,  109,    0,    0,  115,  116,  109,  109,  109,  109, 
       109,  109,  110,  111,  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,    0,    0,  115,  116,  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,    0,  115,  116,  119,  119,  119,  119,  119,  119,  119,    0,    0,    0,  115,  116,  109,  109,  109,  109, 
       117,  117,  110,  111,  120,  120,  120,  120,  120,  120,  120,  120,  120,  120,    0,    0,  115,  116,  120,  120,  120,  120,  120,  120,  120,  120,  120,  120,  120,    0,  115,  116,  109,  109,  109,  109,  109,  109,  109,  109,    0,  121,  122,  116,  117,  117,  117,  117, 
       123,  124,  110,  111,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,    0,  125,  126,  116,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,    0,  115,  116,  117,  117,  117,  117,  117,  117,  117,  117,  123,  124,  123,  124,  123,  124,  123,  124, 
       127,  128,  110,  111,  123,  124,  123,  124,  123,  124,  123,  124,  123,  124,  123,  124,  123,  124,  123,  124,  129,  129,  130,  131,  119,  119,  119,  119,  123,  124,  123,  124,  123,  124,  123,  124,  123,  124,  123,  124,  127,  128,  127,  128,  127,  128,  127,  128, 
       123,  124,  110,  111,  127,  128,  127,  128,  127,  128,  127,  128,  127,  128,  127,  128,  127,  128,  127,  128,  123,  124,  123,  124,  123,  124,  123,  124,  127,  128,  127,  128,  127,  128,  127,  128,  127,  128,  127,  128,  123,  124,  123,  124,  123,  124,  123,  124, 
       127,  128,  130,  131,  129,  129,  132,  133,  134,  134,  134,  134,  134,  134,  134,  134,  132,  133,  132,  133,  127,  128,  127,  128,  127,  128,  127,  128,  121,  122,  121,  122,  135,  136,  137,  137,  137,  137,  137,  137,  127,  128,  127,  128,  127,  128,  127,  128, 
       132,  133,  126,  138,  139,  140,  132,  133,  141,  142,  143,  141,  142,  143,  141,  142,  144,  145,  144,  145,    0,    0,    0,  146,  141,  142,  143,  141,  142,  143,  141,  142,  147,  148,  149,  150,  151,  152,  153,  146,    0,    0,  154,    0,    0,  154,  132,  133, 
       132,  133,  155,  155,  155,  155,  132,  133,  141,  142,  156,  141,  142,  150,  141,  142,  144,  145,  144,  145,    0,    0,    0,  157,  141,  142,  156,  141,  142,  150,  141,  142,  158,  143,  143,  143,  159,  160,  161,  157,  134,  134,  162,  134,  134,  162,  144,  145, 
       132,  133,    0,    0,    0,    0,  132,  133,  141,  142,  163,  141,  142,  164,  141,  142,  144,  145,  144,  145,    0,    0,    0,  146,  141,  142,  163,  141,  142,  164,  141,  142,  147,  160,  161,  159,  155,  155,  155,  146,    0,    0,  165,    0,    0,  165,  144,  145, 
       132,  133,    0,    0,    0,    0,  132,  133,  166,  167,  153,  166,  167,  153,  166,  167,  132,  133,  132,  133,  134,  134,  134,  157,  166,  167,  153,  166,  167,  153,  166,  167,  158,  168,  168,  168,  168,  168,  168,  157,  134,  134,  162,  134,  134,  162,  132,  133, 
       132,  133,  155,  155,  155,  155,  132,  133,  141,  142,  152,  141,  142,  152,  141,  142,  144,  145,  144,  145,    0,    0,    0,  146,  141,  142,  152,  141,  142,  152,  141,  142,  147,  141,  142,  132,  133,  141,  142,  146,  132,  133,  155,  155,  155,  155,  155,  155, 
       132,  133,    0,    0,    0,    0,  132,  133,  141,  142,  156,  141,  142,  150,  141,  142,  144,  145,  144,  145,    0,    0,    0,  157,  141,  142,  156,  141,  142,  150,  141,  142,  158,  141,  142,  132,  133,  141,  142,  157,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  141,  142,  143,  141,  142,  143,  141,  142,  132,  133,  132,  133,    0,    0,    0,  146,  141,  142,  143,  141,  142,  143,  141,  142,  147,  141,  142,  132,  133,  141,  142,  146,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  137,  137,  137,  137,  137,  137,  137,  137,  132,  133,  132,  133,  134,  134,  134,  157,  137,  137,  137,  137,  137,  137,  137,  137,  158,  166,  167,  153,  153,  166,  167,  157,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  169,  170,  160,  161,  160,  161,  171,  136,  144,  145,  144,  145,    0,    0,    0,  146,  169,  170,  160,  161,  160,  161,  171,  136,  147,  141,  142,  132,  133,  141,  142,  146,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  160,  161,  159,  160,  161,  159,  160,  161,  144,  145,  144,  145,  134,  134,  134,  157,  160,  161,  159,  160,  161,  159,  160,  161,  158,  141,  142,  132,  133,  141,  142,  157,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  155,  155,  155,  155,  155,  155,  155,  155,  144,  145,  144,  145,    0,    0,    0,  146,  155,  155,  155,  155,  155,  155,  155,  155,  147,  141,  142,  132,  133,  141,  142,  146,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,  129,  134,  134,  129,  132,  133,  143,  151,  148,  149,  148,  149,  172,  143,  144,  145,  144,  145,    0,    0,    0,  157,  143,  151,  148,  149,  148,  149,  172,  143,  158,  155,  155,  155,  155,  155,  155,  157,  132,  133,    0,    0,    0,    0,    0,    0, 
       132,  133,  155,  155,  155,  155,  132,  133,  141,  142,  152,  141,  142,  152,  141,  142,  144,  145,  144,  145,    0,    0,    0,  146,  141,  142,  152,  141,  142,  152,  141,  142,  147,  141,  142,  132,  133,  141,  142,  146,  132,  133,  155,  155,  155,  155,  155,  155, 
       132,  133,    0,    0,    0,    0,  132,  133,  141,  142,  156,  141,  142,  150,  141,  142,  144,  145,  144,  145,    0,    0,    0,  157,  141,  142,  156,  141,  142,  150,  141,  142,  158,  141,  142,  132,  133,  141,  142,  157,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  141,  142,  143,  141,  142,  143,  141,  142,  132,  133,  132,  133,    0,    0,    0,  146,  141,  142,  143,  141,  142,  143,  141,  142,  147,  141,  142,  132,  133,  141,  142,  146,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  137,  137,  137,  137,  137,  137,  137,  137,  132,  133,  132,  133,  134,  134,  134,  157,  137,  137,  137,  137,  137,  137,  137,  137,  158,  166,  167,  153,  153,  166,  167,  157,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  169,  170,  160,  161,  160,  161,  171,  136,  144,  145,  144,  145,    0,    0,    0,  146,  169,  173,  160,  161,  160,  161,  135,  136,  147,  141,  142,  132,  133,  141,  142,  146,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  160,  161,  159,  160,  161,  159,  160,  161,  144,  145,  144,  145,  134,  134,  134,  157,  160,  161,  159,  160,  161,  159,  160,  161,  158,  141,  142,  132,  133,  141,  142,  157,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  155,  155,  155,  155,  155,  155,  155,  155,  144,  145,  144,  145,    0,    0,    0,  146,  155,  155,  155,  155,  155,  155,  155,  155,  147,  141,  142,  132,  133,  141,  142,  146,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,  129,  134,  134,  129,  132,  133,  143,  151,  148,  149,  148,  149,  172,  143,  144,  145,  144,  145,    0,    0,    0,  157,  143,  151,  148,  149,  148,  149,  172,  143,  158,  155,  155,  155,  155,  155,  155,  157,  132,  133,    0,    0,    0,    0,    0,    0, 
       132,  133,  155,  155,  155,  155,  132,  133,  147,  141,  142,  132,  133,  141,  142,  146,  144,  145,  144,  145,    0,    0,    0,  146,  141,  142,  152,  141,  142,  152,  141,  142,  147,  141,  142,  132,  133,  141,  142,  146,  132,  133,  155,  155,  155,  155,  155,  155, 
       132,  133,    0,    0,    0,    0,  132,  133,  158,  141,  142,  132,  133,  141,  142,  157,  144,  145,  144,  145,    0,    0,    0,  157,  141,  142,  156,  141,  142,  150,  141,  142,  158,  141,  142,  132,  133,  141,  142,  157,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  147,  141,  142,  132,  133,  141,  142,  146,  132,  133,  132,  133,    0,    0,    0,  146,  141,  142,  143,  141,  142,  143,  141,  142,  147,  141,  142,  132,  133,  141,  142,  146,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  158,  166,  167,  153,  153,  166,  167,  157,  132,  133,  132,  133,  134,  134,  134,  157,  137,  137,  137,  137,  137,  137,  137,  137,  158,  166,  167,  153,  153,  166,  167,  157,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  147,  141,  142,  132,  133,  141,  142,  146,  144,  145,  144,  145,    0,    0,    0,  146,  169,  170,  160,  161,  160,  161,  171,  136,  147,  141,  142,  132,  133,  141,  142,  146,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  158,  141,  142,  132,  133,  141,  142,  157,  144,  145,  144,  145,  134,  134,  134,  157,  160,  161,  159,  160,  161,  159,  160,  161,  158,  141,  142,  132,  133,  141,  142,  157,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,    0,    0,    0,    0,  132,  133,  147,  141,  142,  132,  133,  141,  142,  146,  144,  145,  144,  145,    0,    0,    0,  146,  155,  155,  155,  155,  155,  155,  155,  155,  147,  141,  142,  132,  133,  141,  142,  146,  144,  145,    0,    0,    0,    0,    0,    0, 
       132,  133,  129,  134,  134,  129,  132,  133,  158,  155,  155,  155,  155,  155,  155,  157,  144,  145,  144,  145,    0,    0,    0,  157,  143,  151,  148,  149,  148,  149,  172,  143,  158,  155,  155,  155,  155,  155,  155,  157,  132,  133,    0,    0,    0,    0,    0,    0, 
    ]
  end
end