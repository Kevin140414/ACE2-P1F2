/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View,Image,ScrollView,Dimensions} from 'react-native';
import MapView,{ Marker } from 'react-native-maps';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

type Props = {};
export default class App extends Component<Props> {
  constructor(){
        super();
        this.state = {
            markers: [],
            dashboard:true,
        };
        
        /*this.state = {
            markers: [{latitude:37.78825,longitude:-122.4324,title:"title1",description:"description1"},
            		  {latitude:37.78860,longitude:-122.4360,title:"title1",description:"description1"}]
        };*/

    }
    componentWillMount() {
	   	/*this.setState({ showLoading: true});
	   	fetch("https://apex.oracle.com/pls/apex/ace2g3/sensores/ambienteavg/20190225", {method: "GET"})
		.then((response) => response.json())
		.then((responseData) =>
		{
	     	this.setState({ markers: responseData.items,showLoading: false});
	     	//this.setState({ showLoading: true});

		})
		.done(() => {

		});*/
    }

  render() {
    
    if(this.state.dashboard == true){
        return(
            <ScrollView style={styles.scrollContainer}>
                <View style={styles.container}>
                    <View style={styles.box}>
                        <View style={styles.containeri}>
                            <View style={styles.boxi}><Text>Dom.</Text></View>
                            <View style={styles.boxi}><Text>boxi2</Text></View>
                            <View style={styles.boxi}>
                                <Image style={styles.weather} source={require('./img/partly_cloudy.png')}/>
                            </View>
                        </View>
                    </View>
                    <View style={styles.box}>
                        <View style={styles.containeri}>
                            <View style={styles.boxi}><Text>Lun.</Text></View>
                            <View style={styles.boxi}><Text>boxi2</Text></View>
                            <View style={styles.boxi}>
                                <Image style={styles.weather} source={require('./img/rain_s_cloudy.png')}/>
                            </View>
                        </View>
                    </View>
                    <View style={styles.box}>
                        <View style={styles.containeri}>
                            <View style={styles.boxi}><Text>Mar.</Text></View>
                            <View style={styles.boxi}><Text>boxi2</Text></View>
                            <View style={styles.boxi}>
                                <Image style={styles.weather} source={require('./img/sunny_s_cloudy.png')}/>
                            </View>
                        </View>
                    </View>
                    <View style={styles.box}>
                        <View style={styles.containeri}>
                            <View style={styles.boxi}><Text>Mie.</Text></View>
                            <View style={styles.boxi}><Text>boxi2</Text></View>
                            <View style={styles.boxi}>
                                <Image style={styles.weather} source={require('./img/sunny_s_cloudy.png')}/>
                            </View>
                        </View>
                    </View>
                    <View style={styles.box}>
                        <View style={styles.containeri}>
                            <View style={styles.boxi}><Text>Jue.</Text></View>
                            <View style={styles.boxi}><Text>boxi2</Text></View>
                            <View style={styles.boxi}>
                                <Image style={styles.weather} source={require('./img/sunny_s_cloudy.png')}/>
                            </View>
                        </View>
                    </View>
                    <View style={styles.box}>
                        <View style={styles.containeri}>
                            <View style={styles.boxi}><Text>Vie.</Text></View>
                            <View style={styles.boxi}><Text>boxi2</Text></View>
                            <View style={styles.boxi}>
                                <Image style={styles.weather} source={require('./img/sunny_s_cloudy.png')}/>
                            </View>
                        </View>
                    </View>
                    <View style={styles.box}>
                        <View style={styles.containeri}>
                            <View style={styles.boxi}><Text>Sab.</Text></View>
                            <View style={styles.boxi}><Text>boxi2</Text></View>
                            <View style={styles.boxi}>
                                <Image style={styles.weather} source={require('./img/sunny_s_cloudy.png')}/>
                            </View>
                        </View>
                    </View>
                    <View style={styles.box}><Text style={styles.texto8}>Box 8</Text></View>
                </View>
            </ScrollView>
        );
    }else{
        if(this.state.showLoading === true) {
            return (
                /*<Image source={require('./img/cargar.gif')} />*/
                <Image
                  style={styles.gif}
                  source={require('./img/cargar.gif')}
                />
            );
        }else{
            return (
                <MapView
                    style={{
                        flex : 1
                    }}
                    initialRegion={{
                      latitude: 14.504218333333332,
                      longitude: -90.60199166666668,
                      latitudeDelta: 0.0922,
                      longitudeDelta: 0.0421,
                    }}
                  >
                    {this.state.markers.map((marker,index) => (
                           <Marker key={index}
                             coordinate={{latitude: marker.latitud, longitude: marker.longitud}}
                             title={marker.latitud.toString()}
                             //description={marker.mq7.toString() +" - " + marker.latitud.toString() + " - " +  marker.longitud.toString()}
                             description = {marker.mq7.toString()}
                           />

                     ))}
                </MapView>
            );
        } 
    }
    

    
  }
}

const styles = StyleSheet.create({
    scrollContainer:{
        flex: 1,
    },
    container: {
        flex: 1,
        flexDirection: 'row',
        flexWrap: 'wrap',
        padding: 2,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },
    containeri: {
        flex: 2,
        flexDirection: 'row',
        flexWrap: 'wrap',
        padding: 2,
        justifyContent: 'center',
        alignItems: 'center',
        //backgroundColor: '#F5FCFF',
    },
    texto1: {
        fontSize: 20
    },
    instructions: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
    },
    box:{
        margin:2,
        width: Dimensions.get('window').width / 2 -6,
        height: 200,
        justifyContent: 'center',
        alignItems: 'center',
        //backgroundColor: '#f1c40f'
    },

    boxi:{
        margin:2,
        width: Dimensions.get('window').width / 4 -12,
        height: 100,
        justifyContent: 'center',
        alignItems: 'center',
        //backgroundColor: 'blue'
    },

    box1:{
        backgroundColor: 'blue'
    },
    weather:{
        width: 66, 
        height: 58
    }
});
