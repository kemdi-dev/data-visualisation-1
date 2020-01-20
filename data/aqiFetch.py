import pwaqi
import os.path
import csv
import geocoder

username = 'shintalight77'
token = '35aa81a02014bcfdc53d06e8e4e50afe187d0aa8'

locations = []
stationCodes = []

#save file location
save_path ='/Users/vivie/Desktop/data vis/project_2'
name_of_file = 'aqiFetchResults.csv'
name_of_pop_file = 'poplist.csv'
path_address = os.path.join(save_path, name_of_file)
pop_path_address = os.path.join(save_path, name_of_pop_file)

print path_address
file_exists = os.path.isfile(path_address)
pop_file_exists = os.path.isfile(pop_path_address)

'''
    Use if want to update csv instead of overwriting, uncomment makeHeader,
    comment out writing header in write() and change 'wb' to 'ab'
'''
def makeHeader():
    f = open(path_address, 'a')
    writer = csv.writer(f)
    if not file_exists:
        print ('Results file created')
        writer.writerow(['index','aqi','city','lat','lon','time','url'])
    f.close()

def getLocations():
    with open("citiesList.txt","r") as open_file:
        lines = open_file.readline()
        while lines:
            locations.append(lines.strip())
            lines = open_file.readline()
        print locations

    return locations

'''
    This Method will only fetch population data from GeoNames if there is no csv
    created for the population (poplist.csv)
    Requesting data from GeoNames costs "credits" each account token used has daily
    and hourly credit limits

    *NOTICE* 
    If you are simiply testing code not directly related to population data please use
    the tempPoplList to save on credits. Just set the function's return to tempPopList.
'''
def getPopulation():

    populationList = []
    
    f = open(pop_path_address, 'wb')
    writer = csv.writer(f)
    if not pop_file_exists:
        print ('Pop file created')
        writer.writerow(['city','population'])

        for i in range(len(locations)):
            g = geocoder.geonames(locations[i], key = username)
            pop = g.population
            line = [locations[i], pop]
            writer.writerow(line)
            populationList.append(pop)
            
    f.close()

    tempPopList = ['New York', 'Toronto', 'Los Angeles', 'Vancouver', 'Edmonton', 'Calgary', 'Montreal', 'Boston', 'Paulo', 'Celaya', 'Tokyo', 'Kyoto', 'Seoul', 'Hanoi', 'Bangkok', 'Banqiao', 'Central Singapore', 'Jakarta', 'Hong Kong', 'Beijing', 'Shanghai', 'Mumbai', 'Delhi', 'Bangalore', 'Osaka', 'Jeju', 'Dhaka', 'London', 'Paris', 'Firenze', 'Berlin', 'Barcelona', 'Moscow, Russia', 'Fatih, Turkey', 'Kampala', 'Johannesburg', 'Addis Ababa', 'Melbourne'] 

    return populationList
           
def write():
    getLocations();
    '''
create reader from txt file with all the names of locations, put into a list
'''
    for city in locations:
        p = pwaqi.findStationCodesByCity(city, token)
        stationCodes.append(p[0])
    print "Station Codes: ", stationCodes

    poplist = getPopulation()
    print poplist
      
    # if updating csv then change 'wb' to 'ab'
    with open(path_address,'wb') as found:
        writer = csv.writer(found)
        print ('Results file created')
        writer.writerow(['index','aqi','city','lat','lon','time', 'population', 'url'])

        for i in range(len(stationCodes)):
            data = pwaqi.get_station_observation(stationCodes[i], token)
            
            idx = data['idx']
            aqi = data['aqi']
            #must encode to unicode to write in csv
            city = data['city'][u'name'].encode('utf-8')
            geo = data['city'][u'geo']
            time = data['time']
            url = data['city'][u'url']
            pop = poplist[i]

            lat = geo[0]
            lon = geo[1]
            
            if "(" in city:
                x = city.index('(')
                city = city[:x]
                
            line = [idx, aqi, city, lat, lon, time, pop, url]
            writer.writerow(line)
            
            #must decode unicode to print
            print line[2].decode('utf-8')
            print line
               
#makeHeader()
write()

 
