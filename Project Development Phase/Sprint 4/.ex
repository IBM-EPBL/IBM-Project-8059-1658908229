SPRINT 1
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import plotly.express as px
from datetime import datetime
from pprint import pprint
 
from pydrive.auth import GoogleAuth
from pydrive.drive import GoogleDrive
from google.colab import auth
from oauth2client.client import GoogleCredentials
path = "/content/dataset.csv"
df = pd.read_csv(path)
print(df)
       tripduration            starttime             stoptime  \
0               695  2013-06-01 00:00:01  2013-06-01 00:11:36   
1               693  2013-06-01 00:00:08  2013-06-01 00:11:41   
2              2059  2013-06-01 00:00:44  2013-06-01 00:35:03   
3               123  2013-06-01 00:01:04  2013-06-01 00:03:07   
4              1521  2013-06-01 00:01:22  2013-06-01 00:26:43   
...             ...                  ...                  ...   
84087          1478  2013-06-08 14:35:22  2013-06-08 15:00:00   
84088           873  2013-06-08 14:35:31  2013-06-08 14:50:04   
84089          2054  2013-06-08 14:34:51  2013-06-08 15:09:05   
84090          1179  2013-06-08 14:35:28  2013-06-08 14:55:07   
84091           804  2013-06-08 14:35:33                  NaN   

       start station id       start station name  start station latitude  \
0                 444.0       Broadway & W 24 St               40.742354   
1                 444.0       Broadway & W 24 St               40.742354   
2                 406.0   Hicks St & Montague St               40.695128   
3                 475.0      E 15 St & Irving Pl               40.735243   
4                2008.0    Little West St & 1 Pl               40.705693   
...                 ...                      ...                     ...   
84087             337.0      Old Slip & Front St               40.703799   
84088             447.0          8 Ave & W 52 St               40.763707   
84089             229.0           Great Jones St               40.727434   
84090             259.0  South St & Whitehall St               40.701221   
84091               NaN                      NaN                     NaN   

       start station longitude  end station id            end station name  \
0                   -73.989151           434.0             9 Ave & W 18 St   
1                   -73.989151           434.0             9 Ave & W 18 St   
2                   -73.995951           406.0      Hicks St & Montague St   
3                   -73.987586           262.0             Washington Park   
4                   -74.016777           310.0         State St & Smith St   
...                        ...             ...                         ...   
84087               -74.008387           342.0  Columbia St & Rivington St   
84088               -73.985162           404.0             9 Ave & W 14 St   
84089               -73.993790          2012.0             E 27 St & 1 Ave   
84090               -74.012342           383.0  Greenwich Ave & Charles St   
84091                      NaN             NaN                         NaN   

       end station latitude  end station longitude   bikeid    usertype  \
0                 40.743174             -74.003664  19678.0  Subscriber   
1                 40.743174             -74.003664  16649.0  Subscriber   
2                 40.695128             -73.995951  19599.0    Customer   
3                 40.691782             -73.973730  16352.0  Subscriber   
4                 40.689269             -73.989129  15567.0  Subscriber   
...                     ...                    ...      ...         ...   
84087             40.717400             -73.980166  19730.0    Customer   
84088             40.740583             -74.005509  15606.0    Customer   
84089             40.739445             -73.976806  18597.0  Subscriber   
84090             40.735238             -74.000271  14665.0  Subscriber   
84091                   NaN                    NaN      NaN         NaN   

       birth year  gender  
0          1983.0     1.0  
1          1984.0     1.0  
2             NaN     0.0  
3          1960.0     1.0  
4          1983.0     1.0  
...           ...     ...  
84087         NaN     0.0  
84088         NaN     0.0  
84089      1977.0     1.0  
84090      1968.0     2.0  
84091         NaN     NaN  

[84092 rows x 15 columns]
df.head()
tripduration	starttime	stoptime	start station id	start station name	start station latitude	start station longitude	end station id	end station name	end station latitude	end station longitude	bikeid	usertype	birth year	gender
0	695	2013-06-01 00:00:01	2013-06-01 00:11:36	444.0	Broadway & W 24 St	40.742354	-73.989151	434.0	9 Ave & W 18 St	40.743174	-74.003664	19678.0	Subscriber	1983.0	1.0
1	693	2013-06-01 00:00:08	2013-06-01 00:11:41	444.0	Broadway & W 24 St	40.742354	-73.989151	434.0	9 Ave & W 18 St	40.743174	-74.003664	16649.0	Subscriber	1984.0	1.0
2	2059	2013-06-01 00:00:44	2013-06-01 00:35:03	406.0	Hicks St & Montague St	40.695128	-73.995951	406.0	Hicks St & Montague St	40.695128	-73.995951	19599.0	Customer	NaN	0.0
3	123	2013-06-01 00:01:04	2013-06-01 00:03:07	475.0	E 15 St & Irving Pl	40.735243	-73.987586	262.0	Washington Park	40.691782	-73.973730	16352.0	Subscriber	1960.0	1.0
4	1521	2013-06-01 00:01:22	2013-06-01 00:26:43	2008.0	Little West St & 1 Pl	40.705693	-74.016777	310.0	State St & Smith St	40.689269	-73.989129	15567.0	Subscriber	1983.0	1.0
df.describe()
tripduration	start station id	start station latitude	start station longitude	end station id	end station latitude	end station longitude	bikeid	birth year	gender
count	8.409200e+04	84091.000000	84091.000000	84091.000000	81248.000000	81248.000000	81248.000000	84091.000000	43168.000000	84091.000000
mean	2.240372e+03	449.589813	40.731815	-73.990975	451.956479	40.731570	-73.990982	17604.454698	1973.738857	0.622124
std	1.948168e+04	359.983426	0.021619	0.013123	368.024074	0.021642	0.013242	1661.417010	10.937208	0.673987
min	6.100000e+01	72.000000	40.646607	-74.017134	72.000000	40.646607	-74.017134	14529.000000	1899.000000	0.000000
25%	5.540000e+02	312.000000	40.716059	-74.001547	310.000000	40.716021	-74.001547	16178.000000	1966.000000	0.000000
50%	9.580000e+02	404.000000	40.734011	-73.990697	404.000000	40.733812	-73.990741	17620.000000	1976.000000	1.000000
75%	1.509000e+03	483.000000	40.747804	-73.981923	482.000000	40.747659	-73.981923	19075.000000	1982.000000	1.000000
max	3.876479e+06	3020.000000	40.771522	-73.950048	3020.000000	40.771522	-73.950048	20564.000000	1997.000000	2.000000
df.info()
RangeIndex: 84092 entries, 0 to 84091
Data columns (total 15 columns):
 #   Column                   Non-Null Count  Dtype  
---  ------                   --------------  -----  
 0   tripduration             84092 non-null  int64  
 1   starttime                84092 non-null  object 
 2   stoptime                 84091 non-null  object 
 3   start station id         84091 non-null  float64
 4   start station name       84091 non-null  object 
 5   start station latitude   84091 non-null  float64
 6   start station longitude  84091 non-null  float64
 7   end station id           81248 non-null  float64
 8   end station name         81248 non-null  object 
 9   end station latitude     81248 non-null  float64
 10  end station longitude    81248 non-null  float64
 11  bikeid                   84091 non-null  float64
 12  usertype                 84091 non-null  object 
 13  birth year               43168 non-null  float64
 14  gender                   84091 non-null  float64
dtypes: float64(9), int64(1), object(5)
memory usage: 9.6+ MB
df.isnull().sum()
tripduration                   0
starttime                      0
stoptime                       1
start station id               1
start station name             1
start station latitude         1
start station longitude        1
end station id              2844
end station name            2844
end station latitude        2844
end station longitude       2844
bikeid                         1
usertype                       1
birth year                 40924
gender                         1
dtype: int64
df[df['starttime'].isnull()]
tripduration	starttime	stoptime	start station id	start station name	start station latitude	start station longitude	end station id	end station name	end station latitude	end station longitude	bikeid	usertype	birth year	gender
df[df['stoptime'].isnull()]
tripduration	starttime	stoptime	start station id	start station name	start station latitude	start station longitude	end station id	end station name	end station latitude	end station longitude	bikeid	usertype	birth year	gender
84091	804	2013-06-08 14:35:33	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN
df = df[:-1]
df.isnull().sum()
tripduration                   0
starttime                      0
stoptime                       0
start station id               0
start station name             0
start station latitude         0
start station longitude        0
end station id              2843
end station name            2843
end station latitude        2843
end station longitude       2843
bikeid                         0
usertype                       0
birth year                 40923
gender                         0
dtype: int64
print(type(df["start station latitude"][0]))
print(df["start station latitude"][0])
40.7423543
df['start station name'].unique()
array(['Broadway & W 24 St', 'Hicks St & Montague St',
       'E 15 St & Irving Pl', 'Little West St & 1 Pl', 'W 37 St & 5 Ave',
       'Broadway & E 14 St', '9 Ave & W 22 St',
       'Stanton St & Chrystie St', '9 Ave & W 14 St', 'W 54 St & 9 Ave',
       'Henry St & Grand St', 'DeKalb Ave & S Portland Ave',
       'Broadway & W 29 St', 'E 33 St & 2 Ave', 'Murray St & West St',
       'E 20 St & Park Ave', 'Lispenard St & Broadway', 'W 26 St & 8 Ave',
       'W 4 St & 7 Ave S', 'E 58 St & 3 Ave', 'W 53 St & 10 Ave',
       'W 22 St & 8 Ave', 'W 13 St & 7 Ave', 'E 31 St & 3 Ave',
       'Cleveland Pl & Spring St', 'Allen St & Stanton St',
       'W 15 St & 7 Ave', 'E 4 St & 2 Ave', 'Forsyth St & Broome St',
       'Christopher St & Greenwich St', 'Bayard St & Baxter St',
       'Atlantic Ave & Fort Greene Pl', 'Ashland Pl & Hanson Pl',
       'E 10 St & Avenue A', 'W 41 St & 8 Ave', 'Lafayette St & E 8 St',
       'W 45 St & 6 Ave (1)', 'Rivington St & Chrystie St',
       '10 Ave & W 28 St', 'Pershing Square South', '6 Ave & Broome St',
       'NYCBS Depot - DEL', 'Harrison St & Hudson St',
       'E 7 St & Avenue A', 'Franklin St & W Broadway',
       'W 52 St & 11 Ave', 'Broadway & W 41 St', 'Perry St & Bleecker St',
       'Forsyth St & Canal St', '8 Ave & W 31 St N', '8 Ave & W 33 St',
       'Washington Pl & 6 Ave', '6 Ave & W 33 St', 'W 51 St & 6 Ave',
       'Broadway & Berry St', 'W 33 St & 7 Ave', 'St Marks Pl & 2 Ave',
       'Catherine St & Monroe St', 'E 11 St & Broadway',
       'S 5 Pl & S 5 St', 'Great Jones St', 'Mercer St & Spring St',
       'W 20 St & 8 Ave', 'Emerson Pl & Myrtle Ave',
       'Shevchenko Pl & E 7 St', 'Lawrence St & Willoughby St',
       'Cadman Plaza W & Pierrepont St', '1 Ave & E 16 St',
       'S 3 St & Bedford Ave', 'Henry St & Atlantic Ave',
       'Clinton St & Joralemon St', 'E 52 St & 2 Ave',
       'Willoughby Ave & Hall St', 'E 60 St & York Ave',
       'Grand Army Plaza & Central Park S', 'W 46 St & 11 Ave',
       'Pike St & E Broadway', 'Clermont Ave & Lafayette Ave',
       'Suffolk St & Stanton St', '2 Ave & E 31 St',
       'Norfolk St & Broome St', 'Watts St & Greenwich St',
       'Adelphi St & Myrtle Ave', 'Hudson St & Reade St',
       'W 25 St & 6 Ave', 'W 39 St & 9 Ave', '8 Ave & W 52 St',
       'Broadway & W 37 St', '12 Ave & W 40 St',
       'South St & Whitehall St', 'Washington Square E',
       'Mott St & Prince St', 'Bank St & Washington St',
       'John St & William St', 'Old Fulton St', 'E 20 St & 2 Ave',
       'Jay St & Tech Pl', 'Washington St & Gansevoort St',
       'W 20 St & 11 Ave', 'E 3 St & 1 Ave',
       'MacDougal St & Washington Sq', 'Fulton St & Washington Ave',
       '6 Ave & Canal St', 'Bus Slip & State St',
       'Willoughby St & Fleet St', 'Concord St & Bridge St',
       '9 Ave & W 45 St', 'W 18 St & 6 Ave', 'E 5 St & Avenue C',
       'E 39 St & 2 Ave', 'Mercer St & Bleecker St S',
       'DeKalb Ave & Hudson Ave', 'E 47 St & 1 Ave', 'W 27 St & 7 Ave',
       '11 Ave & W 41 St', 'West St & Chambers St', 'E 11 St & 1 Ave',
       'St James Pl & Pearl St', 'W Broadway & Spring St',
       'S 4 St & Wythe Ave', 'Clinton St & Grand St', 'E 2 St & Avenue C',
       'St James Pl & Oliver St', 'Sullivan St & Washington Sq',
       'W 14 St & The High Line', 'W 49 St & 8 Ave', 'Broadway & W 53 St',
       'W 38 St & 8 Ave', 'Greenwich Ave & 8 Ave',
       'Rivington St & Ridge St', 'LaGuardia Pl & W 3 St',
       'Metropolitan Ave & Bedford Ave', 'Greenwich St & North Moore St',
       'Atlantic Ave & Furman St', 'University Pl & E 14 St',
       'E 39 St & 3 Ave', 'Broadway & E 22 St', 'Centre St & Worth St',
       '3 Ave & Schermerhorn St', 'W 22 St & 10 Ave',
       'Allen St & Rivington St', 'Cliff St & Fulton St',
       'W 17 St & 8 Ave', 'Cumberland St & Lafayette Ave',
       'W 59 St & 10 Ave', 'Broadway & W 51 St',
       'Water - Whitehall Plaza', 'Fulton St & Clermont Ave',
       'W 47 St & 10 Ave', 'W 20 St & 7 Ave', 'Carmine St & 6 Ave',
       'Greenwich St & W Houston St', 'Broadway & W 32 St',
       'E 10 St & 5 Ave', 'Lefferts Pl & Franklin Ave', '2 Ave & E 58 St',
       'St Marks Pl & 1 Ave', 'W 24 St & 7 Ave', '11 Ave & W 27 St',
       'W 16 St & The High Line', 'E 27 St & 1 Ave', 'W 43 St & 10 Ave',
       'Bond St & Schermerhorn St', 'Lexington Ave & E 29 St',
       'W 29 St & 9 Ave', 'Washington Ave & Greene Ave',
       'Kent Ave & S 11 St', 'W 21 St & 6 Ave', 'E 2 St & 2 Ave',
       '9 Ave & W 16 St', 'Howard St & Centre St',
       'MacDougal St & Prince St', 'Washington Ave & Park Ave',
       'E 14 St & Avenue B', 'Clark St & Henry St', 'Broadway & W 49 St',
       'Clinton Ave & Myrtle Ave', 'Pearl St & Anchorage Pl',
       'E 25 St & 2 Ave', 'E 17 St & Broadway',
       'S Portland Ave & Hanson Pl', 'W 26 St & 10 Ave',
       'E 51 St & Lexington Ave', 'Division St & Bowery',
       'Barrow St & Hudson St', 'Cadman Plaza E & Red Cross Pl',
       'Warren St & Church St', 'W 34 St & 11 Ave', 'NYCBS Test',
       'West Thames St', 'Allen St & Hester St',
       'DeKalb Ave & Vanderbilt Ave', 'E 32 St & Park Ave',
       'Leonard St & Church St', 'W 13 St & 5 Ave',
       'Bialystoker Pl & Delancey St', 'Fulton St & Grand Ave',
       'E 53 St & Madison Ave', 'Cadman Plaza West & Montague St',
       'Broadway & W 58 St', 'E 47 St & 2 Ave', 'W 13 St & 6 Ave',
       'Macon St & Nostrand Ave', 'Fulton St & Rockwell Pl',
       'W 37 St & 10 Ave', 'Broadway & Battery Pl', 'Washington Park',
       'E 19 St & 3 Ave', 'Maiden Ln & Pearl St', '1 Ave & E 44 St',
       '11 Ave & W 59 St', 'Columbia Heights & Cranberry St',
       'South End Ave & Liberty St', 'Broadway & W 56 St',
       'Bank St & Hudson St', 'Central Park S & 6 Ave',
       'E 53 St & Lexington Ave', 'Monroe St & Bedford Ave',
       'Pershing Square North', '1 Ave & E 30 St',
       'Canal St & Rutgers St', 'Market St & Cherry St',
       'Reade St & Broadway', 'Greenwich St & Warren St',
       'E 20 St & FDR Drive', 'E 13 St & Avenue A',
       'Lexington Ave & E 24 St', 'E 2 St & Avenue B',
       'Lafayette Ave & Classon Ave', 'W 11 St & 6 Ave',
       'Lafayette Ave & St James Pl', 'Barclay St & Church St',
       'W 52 St & 9 Ave', 'E 9 St & Avenue C', 'Old Slip & Front St',
       'Johnson St & Gold St', 'York St & Jay St',
       'South St & Gouverneur Ln', '1 Ave & E 18 St', 'E 12 St & 3 Ave',
       'Broad St & Bridge St', 'State St & Smith St',
       'Fulton St & William St', 'E 6 St & Avenue B', 'E 15 St & 3 Ave',
       'Duane St & Greenwich St', 'E 51 St & 1 Ave', 'Front St & Gold St',
       'Broadway & W 38 St', 'Madison St & Montgomery St', 'Cherry St',
       'E 11 St & 2 Ave', 'Columbia St & Rivington St', 'W 42 St & 8 Ave',
       'E 56 St & 3 Ave', '5 Ave & E 29 St', 'Spruce St & Nassau St',
       'E 24 St & Park Ave S', 'E 25 St & 1 Ave',
       'Lafayette St & Jersey St N', 'Avenue D & E 8 St',
       'Greenwich Ave & Charles St', 'Front St & Washington St',
       'Fulton St & Broadway', 'NYCBS Depot - FAR', 'E 47 St & Park Ave',
       'Carlton Ave & Flushing Ave', 'Lafayette Ave & Fort Greene Pl',
       'Grand St & Havemeyer St', 'Carlton Ave & Park Ave',
       'Washington Pl & Broadway', 'FDR Drive & E 35 St',
       'E 23 St & 1 Ave', 'Broadway & W 60 St', 'E 55 St & Lexington Ave',
       'W 56 St & 10 Ave', 'W 31 St & 7 Ave', 'Vesey Pl & River Terrace',
       'Park Ave & St Edwards St', 'E 55 St & 2 Ave',
       'Lexington Ave & Classon Ave', 'Liberty St & Broadway',
       'W 52 St & 5 Ave', 'E 30 St & Park Ave S', 'E 40 St & 5 Ave',
       'Henry St & Poplar St', 'Clinton Ave & Flushing Ave',
       'E 56 St & Madison Ave', 'Pike St & Monroe St',
       'Grand St & Greene St', 'NYCBS Depot - SSP',
       'E 48 St & Madison Ave', 'E 16 St & 5 Ave', 'E 33 St & 5 Ave',
       'W 56 St & 6 Ave', 'E 6 St & Avenue D', 'W 45 St & 8 Ave',
       'Franklin Ave & Myrtle Ave', 'Cadman Plaza E & Tillary St',
       'Clermont Ave & Park Ave', 'Front St & Maiden Ln',
       'Willoughby Ave & Walworth St', 'Madison St & Clinton St',
       'Broadway & W 36 St', 'Pearl St & Hanover Square',
       'William St & Pine St', 'Avenue D & E 3 St',
       'Stanton St & Mangin St', 'Wythe Ave & Metropolitan Ave',
       '9 Ave & W 18 St', 'Clinton St & Tillary St',
       'Hancock St & Bedford Ave', 'Duffield St & Willoughby St',
       'Peck Slip & Front St', 'Monroe St & Classon Ave',
       'Nassau St & Navy St', 'Myrtle Ave & St Edwards St',
       'Railroad Ave & Kay Ave', 'Sands St & Navy St', 'E 45 St & 3 Ave',
       'W 43 St & 6 Ave', 'Avenue D & E 12 St', 'W 44 St & 5 Ave',
       'E 48 St & 3 Ave', 'Elizabeth St & Hester St',
       '3969.TEMP (Bike The Branches - Central Branch)',
       'Dean St & 4 Ave', 'Bedford Ave & S 9 St',
       'E 43 St & Vanderbilt Ave', 'Hanover Pl & Livingston St',
       'Gallatin Pl & Livingston St', 'Pitt St & Stanton St',
       'Laight St & Hudson St', 'Centre St & Chambers St', 'MLSWKiosk'],
      dtype=object)
def camel_case(city):
    try:
        city = city.split(' ')
        city = ' '.join([x.lower().capitalize() for x in city])
        if city == 'Unknown':
            return np.nan
        else:
            return city
    except:
        return np.nan
    
# Apply camel_case function to City column
df['start station name'] = df['start station name'].apply(camel_case)
df['start station name'].value_counts()
E 17 St & Broadway            919
W 20 St & 11 Ave              860
Broadway & W 58 St            834
Broadway & E 14 St            833
Broadway & W 24 St            769
                             ... 
Hanover Pl & Livingston St     16
E 48 St & 3 Ave                 6
Elizabeth St & Hester St        5
Mlswkiosk                       2
E 40 St & 5 Ave                 1
Name: start station name, Length: 335, dtype: int64
df.count()
tripduration               84091
starttime                  84091
stoptime                   84091
start station id           84091
start station name         84091
start station latitude     84091
start station longitude    84091
end station id             81248
end station name           81248
end station latitude       81248
end station longitude      81248
bikeid                     84091
usertype                   84091
birth year                 43168
gender                     84091
dtype: int64
df["tripduration"] = pd.to_numeric(df["tripduration"])
res = df.iloc[52323]
print(res["tripduration"])
1116
df_filtered = df[df['tripduration'] != "tripduration"]
df_filtered["tripduration"] = pd.to_numeric(df_filtered["tripduration"])
df = df_filtered
type(df["tripduration"][0])
numpy.int64
type(df["start station latitude"][0])
numpy.float64
type(df["end station longitude"][0])
numpy.float64
type(df["bikeid"][0])
numpy.float64
type(df["birth year"][0])
numpy.float64
type(df["gender"][0])
numpy.float64
type(df["starttime"][0])
str
df["starttime"] = pd.to_datetime(df["starttime"])
df["stoptime"] = pd.to_datetime(df["stoptime"])
type(df["starttime"][0])
pandas._libs.tslibs.timestamps.Timestamp
df["starttime"][0] < df["stoptime"][0]
True
df.info()
Int64Index: 84091 entries, 0 to 84090
Data columns (total 15 columns):
 #   Column                   Non-Null Count  Dtype         
---  ------                   --------------  -----         
 0   tripduration             84091 non-null  int64         
 1   starttime                84091 non-null  datetime64[ns]
 2   stoptime                 84091 non-null  datetime64[ns]
 3   start station id         84091 non-null  float64       
 4   start station name       84091 non-null  object        
 5   start station latitude   84091 non-null  float64       
 6   start station longitude  84091 non-null  float64       
 7   end station id           81248 non-null  float64       
 8   end station name         81248 non-null  object        
 9   end station latitude     81248 non-null  float64       
 10  end station longitude    81248 non-null  float64       
 11  bikeid                   84091 non-null  float64       
 12  usertype                 84091 non-null  object        
 13  birth year               43168 non-null  float64       
 14  gender                   84091 non-null  float64       
dtypes: datetime64[ns](2), float64(9), int64(1), object(3)
memory usage: 12.3+ MB
def find_outliers_IQR(df):
   q1=df.quantile(0.25)
   q3=df.quantile(0.75)
   IQR=q3-q1
   outliers = df[((df<(q1-1.5*IQR)) | (df>(q3+1.5*IQR)))]
   return outliers
outliers = find_outliers_IQR(df["birth year"])
print("number of outliers: " + str(len(outliers)))
print("max outlier value: " + str(outliers.max()))
print("min outlier value: " + str(outliers.min()))
number of outliers: 136
max outlier value: 1941.0
min outlier value: 1899.0
df["gender"].value_counts()
0.0    40991
1.0    33885
2.0     9215
Name: gender, dtype: int64
temp_df = df[df["birth year"] <= 1957]
temp_df["gender"].value_counts()
1.0    2985
2.0     849
Name: gender, dtype: int64
df.shape
(84091, 15)
df.to_csv('cleaned_dataset.csv', index=False)
SPRINT 4
path = "/content/cleaned_dataset.csv"
edadf = pd.read_csv(path)
print(edadf)
       tripduration            starttime             stoptime  \
0               695  2013-06-01 00:00:01  2013-06-01 00:11:36   
1               693  2013-06-01 00:00:08  2013-06-01 00:11:41   
2              2059  2013-06-01 00:00:44  2013-06-01 00:35:03   
3               123  2013-06-01 00:01:04  2013-06-01 00:03:07   
4              1521  2013-06-01 00:01:22  2013-06-01 00:26:43   
...             ...                  ...                  ...   
84086          1506  2013-06-08 14:35:22  2013-06-08 15:00:28   
84087          1478  2013-06-08 14:35:22  2013-06-08 15:00:00   
84088           873  2013-06-08 14:35:31  2013-06-08 14:50:04   
84089          2054  2013-06-08 14:34:51  2013-06-08 15:09:05   
84090          1179  2013-06-08 14:35:28  2013-06-08 14:55:07   

       start station id       start station name  start station latitude  \
0                 444.0       Broadway & W 24 St               40.742354   
1                 444.0       Broadway & W 24 St               40.742354   
2                 406.0   Hicks St & Montague St               40.695128   
3                 475.0      E 15 St & Irving Pl               40.735243   
4                2008.0    Little West St & 1 Pl               40.705693   
...                 ...                      ...                     ...   
84086             422.0         W 59 St & 10 Ave               40.770513   
84087             337.0      Old Slip & Front St               40.703799   
84088             447.0          8 Ave & W 52 St               40.763707   
84089             229.0           Great Jones St               40.727434   
84090             259.0  South St & Whitehall St               40.701221   

       start station longitude  end station id            end station name  \
0                   -73.989151           434.0             9 Ave & W 18 St   
1                   -73.989151           434.0             9 Ave & W 18 St   
2                   -73.995951           406.0      Hicks St & Montague St   
3                   -73.987586           262.0             Washington Park   
4                   -74.016777           310.0         State St & Smith St   
...                        ...             ...                         ...   
84086               -73.988038           212.0     W 16 St & The High Line   
84087               -74.008387           342.0  Columbia St & Rivington St   
84088               -73.985162           404.0             9 Ave & W 14 St   
84089               -73.993790          2012.0             E 27 St & 1 Ave   
84090               -74.012342           383.0  Greenwich Ave & Charles St   

       end station latitude  end station longitude   bikeid    usertype  \
0                 40.743174             -74.003664  19678.0  Subscriber   
1                 40.743174             -74.003664  16649.0  Subscriber   
2                 40.695128             -73.995951  19599.0    Customer   
3                 40.691782             -73.973730  16352.0  Subscriber   
4                 40.689269             -73.989129  15567.0  Subscriber   
...                     ...                    ...      ...         ...   
84086             40.743349             -74.006818  19225.0    Customer   
84087             40.717400             -73.980166  19730.0    Customer   
84088             40.740583             -74.005509  15606.0    Customer   
84089             40.739445             -73.976806  18597.0  Subscriber   
84090             40.735238             -74.000271  14665.0  Subscriber   

       birth year  gender  
0          1983.0     1.0  
1          1984.0     1.0  
2             NaN     0.0  
3          1960.0     1.0  
4          1983.0     1.0  
...           ...     ...  
84086         NaN     0.0  
84087         NaN     0.0  
84088         NaN     0.0  
84089      1977.0     1.0  
84090      1968.0     2.0  

[84091 rows x 15 columns]
temp = edadf
temp.head()
tripduration	starttime	stoptime	start station id	start station name	start station latitude	start station longitude	end station id	end station name	end station latitude	end station longitude	bikeid	usertype	birth year	gender
0	695	2013-06-01 00:00:01	2013-06-01 00:11:36	444.0	Broadway & W 24 St	40.742354	-73.989151	434.0	9 Ave & W 18 St	40.743174	-74.003664	19678.0	Subscriber	1983.0	1.0
1	693	2013-06-01 00:00:08	2013-06-01 00:11:41	444.0	Broadway & W 24 St	40.742354	-73.989151	434.0	9 Ave & W 18 St	40.743174	-74.003664	16649.0	Subscriber	1984.0	1.0
2	2059	2013-06-01 00:00:44	2013-06-01 00:35:03	406.0	Hicks St & Montague St	40.695128	-73.995951	406.0	Hicks St & Montague St	40.695128	-73.995951	19599.0	Customer	NaN	0.0
3	123	2013-06-01 00:01:04	2013-06-01 00:03:07	475.0	E 15 St & Irving Pl	40.735243	-73.987586	262.0	Washington Park	40.691782	-73.973730	16352.0	Subscriber	1960.0	1.0
4	1521	2013-06-01 00:01:22	2013-06-01 00:26:43	2008.0	Little West St & 1 Pl	40.705693	-74.016777	310.0	State St & Smith St	40.689269	-73.989129	15567.0	Subscriber	1983.0	1.0
temp.describe()
tripduration	start station id	start station latitude	start station longitude	end station id	end station latitude	end station longitude	bikeid	birth year	gender
count	8.409100e+04	84091.000000	84091.000000	84091.000000	81248.000000	81248.000000	81248.000000	84091.000000	43168.000000	84091.000000
mean	2.240389e+03	449.589813	40.731815	-73.990975	451.956479	40.731570	-73.990982	17604.454698	1973.738857	0.622124
std	1.948179e+04	359.983426	0.021619	0.013123	368.024074	0.021642	0.013242	1661.417010	10.937208	0.673987
min	6.100000e+01	72.000000	40.646607	-74.017134	72.000000	40.646607	-74.017134	14529.000000	1899.000000	0.000000
25%	5.540000e+02	312.000000	40.716059	-74.001547	310.000000	40.716021	-74.001547	16178.000000	1966.000000	0.000000
50%	9.580000e+02	404.000000	40.734011	-73.990697	404.000000	40.733812	-73.990741	17620.000000	1976.000000	1.000000
75%	1.509000e+03	483.000000	40.747804	-73.981923	482.000000	40.747659	-73.981923	19075.000000	1982.000000	1.000000
max	3.876479e+06	3020.000000	40.771522	-73.950048	3020.000000	40.771522	-73.950048	20564.000000	1997.000000	2.000000
temp.info()
RangeIndex: 84091 entries, 0 to 84090
Data columns (total 15 columns):
 #   Column                   Non-Null Count  Dtype  
---  ------                   --------------  -----  
 0   tripduration             84091 non-null  int64  
 1   starttime                84091 non-null  object 
 2   stoptime                 84091 non-null  object 
 3   start station id         84091 non-null  float64
 4   start station name       84091 non-null  object 
 5   start station latitude   84091 non-null  float64
 6   start station longitude  84091 non-null  float64
 7   end station id           81248 non-null  float64
 8   end station name         81248 non-null  object 
 9   end station latitude     81248 non-null  float64
 10  end station longitude    81248 non-null  float64
 11  bikeid                   84091 non-null  float64
 12  usertype                 84091 non-null  object 
 13  birth year               43168 non-null  float64
 14  gender                   84091 non-null  float64
dtypes: float64(9), int64(1), object(5)
memory usage: 9.6+ MB
temp["starttime"] = pd.to_datetime(temp["starttime"])
temp["stoptime"] = pd.to_datetime(temp["stoptime"])
temp.info()
temp["Hour"] = temp["stoptime"].dt.hour - temp["starttime"].dt.hour
temp.head()
temp.shape
(84091, 16)
temp['Age'] = 2022 - temp['birth year']
temp.head()
tripduration	starttime	stoptime	start station id	start station name	start station latitude	start station longitude	end station id	end station name	end station latitude	end station longitude	bikeid	usertype	birth year	gender	Hour	Age
0	695	2013-06-01 00:00:01	2013-06-01 00:11:36	444.0	Broadway & W 24 St	40.742354	-73.989151	434.0	9 Ave & W 18 St	40.743174	-74.003664	19678.0	Subscriber	1983.0	1.0	0	39.0
1	693	2013-06-01 00:00:08	2013-06-01 00:11:41	444.0	Broadway & W 24 St	40.742354	-73.989151	434.0	9 Ave & W 18 St	40.743174	-74.003664	16649.0	Subscriber	1984.0	1.0	0	38.0
2	2059	2013-06-01 00:00:44	2013-06-01 00:35:03	406.0	Hicks St & Montague St	40.695128	-73.995951	406.0	Hicks St & Montague St	40.695128	-73.995951	19599.0	Customer	NaN	0.0	0	NaN
3	123	2013-06-01 00:01:04	2013-06-01 00:03:07	475.0	E 15 St & Irving Pl	40.735243	-73.987586	262.0	Washington Park	40.691782	-73.973730	16352.0	Subscriber	1960.0	1.0	0	62.0
4	1521	2013-06-01 00:01:22	2013-06-01 00:26:43	2008.0	Little West St & 1 Pl	40.705693	-74.016777	310.0	State St & Smith St	40.689269	-73.989129	15567.0	Subscriber	1983.0	1.0	0	39.0
Age_Groups = ["<20", "20-29", "30-39", "40-49", "50-59", "60+"]
Age_Groups_Limits = [0, 20, 30, 40, 50, 60, np.inf]
Age_Min = 0
Age_Max = 100
temp["Age_group"] = pd.cut(temp["Age"], Age_Groups_Limits, labels=Age_Groups)
temp.head()
tripduration	starttime	stoptime	start station id	start station name	start station latitude	start station longitude	end station id	end station name	end station latitude	end station longitude	bikeid	usertype	birth year	gender	Hour	Age	Age_group
0	695	2013-06-01 00:00:01	2013-06-01 00:11:36	444.0	Broadway & W 24 St	40.742354	-73.989151	434.0	9 Ave & W 18 St	40.743174	-74.003664	19678.0	Subscriber	1983.0	1.0	0	39.0	30-39
1	693	2013-06-01 00:00:08	2013-06-01 00:11:41	444.0	Broadway & W 24 St	40.742354	-73.989151	434.0	9 Ave & W 18 St	40.743174	-74.003664	16649.0	Subscriber	1984.0	1.0	0	38.0	30-39
2	2059	2013-06-01 00:00:44	2013-06-01 00:35:03	406.0	Hicks St & Montague St	40.695128	-73.995951	406.0	Hicks St & Montague St	40.695128	-73.995951	19599.0	Customer	NaN	0.0	0	NaN	NaN
3	123	2013-06-01 00:01:04	2013-06-01 00:03:07	475.0	E 15 St & Irving Pl	40.735243	-73.987586	262.0	Washington Park	40.691782	-73.973730	16352.0	Subscriber	1960.0	1.0	0	62.0	60+
4	1521	2013-06-01 00:01:22	2013-06-01 00:26:43	2008.0	Little West St & 1 Pl	40.705693	-74.016777	310.0	State St & Smith St	40.689269	-73.989129	15567.0	Subscriber	1983.0	1.0	0	39.0	30-39
trips_df = pd.DataFrame()
trips_df = temp.groupby(['start station name','end station name']).size().reset_index(name = 'Number of Trips')
trips_df = trips_df.sort_values('Number of Trips',ascending = False)
trips_df["start station name"] = trips_df["start station name"].astype(str)
trips_df["end station name"] = trips_df["end station name"].astype(str)
trips_df["Routes"] = trips_df["start station name"] + " to " + trips_df["end station name"]
trips_df = trips_df[:50]
trips_df = trips_df.reset_index()
trips_df
index	start station name	end station name	Number of Trips	Routes
0	8964	Central Park S & 6 Ave	Central Park S & 6 Ave	153	Central Park S & 6 Ave to Central Park S & 6 Ave
1	7521	Broadway & W 58 St	Broadway & W 58 St	114	Broadway & W 58 St to Broadway & W 58 St
2	37933	West Thames St	West Thames St	64	West Thames St to West Thames St
3	3990	Atlantic Ave & Furman St	Old Fulton St	58	Atlantic Ave & Furman St to Old Fulton St
4	36141	W 56 St & 6 Ave	W 56 St & 6 Ave	57	W 56 St & 6 Ave to W 56 St & 6 Ave
5	7341	Broadway & W 56 St	Broadway & W 56 St	55	Broadway & W 56 St to Broadway & W 56 St
6	9101	Centre St & Chambers St	Centre St & Chambers St	48	Centre St & Chambers St to Centre St & Chamber...
7	25989	Old Fulton St	Old Fulton St	48	Old Fulton St to Old Fulton St
8	10855	Dean St & 4 Ave	Dean St & 4 Ave	46	Dean St & 4 Ave to Dean St & 4 Ave
9	3945	Atlantic Ave & Furman St	Atlantic Ave & Furman St	46	Atlantic Ave & Furman St to Atlantic Ave & Fur...
10	5161	Broadway & Battery Pl	Broadway & Battery Pl	43	Broadway & Battery Pl to Broadway & Battery Pl
11	20859	Greenwich St & North Moore St	Greenwich St & North Moore St	41	Greenwich St & North Moore St to Greenwich St ...
12	7804	Bus Slip & State St	Bus Slip & State St	39	Bus Slip & State St to Bus Slip & State St
13	25155	Metropolitan Ave & Bedford Ave	Metropolitan Ave & Bedford Ave	39	Metropolitan Ave & Bedford Ave to Metropolitan...
14	25928	Old Fulton St	Atlantic Ave & Furman St	39	Old Fulton St to Atlantic Ave & Furman St
15	38258	Wythe Ave & Metropolitan Ave	Wythe Ave & Metropolitan Ave	36	Wythe Ave & Metropolitan Ave to Wythe Ave & Me...
16	13086	E 17 St & Broadway	E 17 St & Broadway	35	E 17 St & Broadway to E 17 St & Broadway
17	4275	Bank St & Washington St	Bank St & Washington St	34	Bank St & Washington St to Bank St & Washingto...
18	28075	South St & Gouverneur Ln	South St & Gouverneur Ln	33	South St & Gouverneur Ln to South St & Gouvern...
19	4576	Barrow St & Hudson St	Barrow St & Hudson St	32	Barrow St & Hudson St to Barrow St & Hudson St
20	9521	Christopher St & Greenwich St	Christopher St & Greenwich St	31	Christopher St & Greenwich St to Christopher S...
21	7518	Broadway & W 58 St	Broadway & W 51 St	31	Broadway & W 58 St to Broadway & W 51 St
22	37730	West St & Chambers St	West St & Chambers St	31	West St & Chambers St to West St & Chambers St
23	15754	E 39 St & 2 Ave	2 Ave & E 31 St	30	E 39 St & 2 Ave to 2 Ave & E 31 St
24	30225	W 14 St & The High Line	W 14 St & The High Line	29	W 14 St & The High Line to W 14 St & The High ...
25	38065	William St & Pine St	William St & Pine St	29	William St & Pine St to William St & Pine St
26	1005	12 Ave & W 40 St	12 Ave & W 40 St	29	12 Ave & W 40 St to 12 Ave & W 40 St
27	8959	Central Park S & 6 Ave	Broadway & W 58 St	29	Central Park S & 6 Ave to Broadway & W 58 St
28	19612	Front St & Washington St	Front St & Washington St	28	Front St & Washington St to Front St & Washing...
29	5885	Broadway & W 24 St	E 17 St & Broadway	28	Broadway & W 24 St to E 17 St & Broadway
30	31107	W 20 St & 11 Ave	W 20 St & 11 Ave	28	W 20 St & 11 Ave to W 20 St & 11 Ave
31	4115	Bank St & Hudson St	Bank St & Hudson St	27	Bank St & Hudson St to Bank St & Hudson St
32	21265	Greenwich St & Warren St	West Thames St	27	Greenwich St & Warren St to West Thames St
33	5305	Broadway & Berry St	Broadway & Berry St	26	Broadway & Berry St to Broadway & Berry St
34	5398	Broadway & E 14 St	Broadway & E 14 St	26	Broadway & E 14 St to Broadway & E 14 St
35	18105	E 58 St & 3 Ave	E 58 St & 3 Ave	26	E 58 St & 3 Ave to E 58 St & 3 Ave
36	7342	Broadway & W 56 St	Broadway & W 58 St	25	Broadway & W 56 St to Broadway & W 58 St
37	7013	Broadway & W 51 St	Broadway & W 51 St	25	Broadway & W 51 St to Broadway & W 51 St
38	753	11 Ave & W 41 St	11 Ave & W 41 St	25	11 Ave & W 41 St to 11 Ave & W 41 St
39	22335	John St & William St	John St & William St	25	John St & William St to John St & William St
40	10427	Clinton St & Joralemon St	Clinton St & Joralemon St	25	Clinton St & Joralemon St to Clinton St & Jora...
41	37589	West St & Chambers St	Bus Slip & State St	24	West St & Chambers St to Bus Slip & State St
42	868	11 Ave & W 59 St	11 Ave & W 59 St	24	11 Ave & W 59 St to 11 Ave & W 59 St
43	29584	Vesey Pl & River Terrace	Vesey Pl & River Terrace	24	Vesey Pl & River Terrace to Vesey Pl & River T...
44	5841	Broadway & W 24 St	Broadway & W 24 St	24	Broadway & W 24 St to Broadway & W 24 St
45	34286	W 43 St & 10 Ave	W 43 St & 10 Ave	23	W 43 St & 10 Ave to W 43 St & 10 Ave
46	2527	9 Ave & W 14 St	9 Ave & W 14 St	23	9 Ave & W 14 St to 9 Ave & W 14 St
47	1138	12 Ave & W 40 St	West St & Chambers St	23	12 Ave & W 40 St to West St & Chambers St
48	1146	2 Ave & E 31 St	2 Ave & E 31 St	23	2 Ave & E 31 St to 2 Ave & E 31 St
49	25513	Murray St & West St	Murray St & West St	23	Murray St & West St to Murray St & West St
px.pie(values = temp['gender'].value_counts(),
       names =temp['gender'].value_counts().index,
       title ="Gender Variation")
px.bar(x=temp["start station name"].value_counts().index,
       y=temp["start station name"].value_counts().values,
       labels={'x':'Start Station Name',"y":"Count"})
px.bar(x=temp["end station name"].value_counts().index,
       y=temp["end station name"].value_counts().values,
       labels={'x':'End Station Name',"y":"Count"})
px.bar(x=temp["Hour"].value_counts().index,
       y=temp["Hour"].value_counts().values,
       title = "Hour usage of Citi Bikes",
       labels={'x':'Time',"y":"Number of people using bike"})

