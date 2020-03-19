import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Particles 2.0
Window {
    visible: true
    width: 800
    height: 530
    title: qsTr("Hello World")

    color:"black"


    ParticleSystem{
        id:particles
        anchors.fill: parent

        ImageParticle{
            groups:["stage1"]
            source: "qrc:///particleresources/star.png"
            alphaVariation: 0.4
            colorVariation: 0.9
        }

        Emitter{
            id:burstEmitter
            x:400;y:480
            group:"stage1"
            emitRate: 1;lifeSpan: 1500;
            size: 50;endSize: 10;sizeVariation: 30;
            acceleration:PointDirection{y:100}
            velocity: AngleDirection{angle: 270;magnitude: 400;
            angleVariation:40;magnitudeVariation: 50}
         }

         ImageParticle{
             groups: "stage2"
             source: "qrc:///particleresources/glowdot.png"
             color:"#11111111"
         }

         TrailEmitter{
             group: "stage2";follow: "stage1"
             emitRatePerParticle: 100;lifeSpan: 2400
             lifeSpanVariation: 400
             acceleration: PointDirection{y:-60}
             velocity: AngleDirection{angle:270;magnitude: 40;
                 angleVariation: 22;magnitudeVariation: 5}
             size: 16;endSize: 0;sizeVariation: 8;
         }

         ImageParticle{
             id:imageParticle
             groups: "stage3"
             source: "qrc:///particleresources/star.png"
             alpha: 0
             colorVariation: 0.2
             entryEffect: ImageParticle.Scale
             rotation: 60
             rotationVariation: 30
             rotationVelocity: 45
             rotationVelocityVariation: 15
         }
         Emitter{
             id:brustEmitter2
             group: "stage3"
             emitRate: 4000;lifeSpan: 3000;
             size:30; endSize:5; sizeVariation:10
             enabled: false
             velocity: CumulativeDirection{
                 AngleDirection{angleVariation:360;magnitudeVariation:80;}
                 PointDirection{y:20}
             }
             acceleration:PointDirection{y:10}
         }
    }
    Affector{
        system: particles
        width:parent.width
        height:10; y:90
        once: true
        groups: "stage1"
        onAffectParticles: {
            for(var i=0;i<particles.length;i++){
                brustEmitter2.burst(300,particles[i].x,particles[i].y);
                imageParticle.color=Qt.rgba(particles[i].red,
                                            particles[i].green,
                                            particles[i].blue,
                                            particles[i].alpha)
            }
        }
    }


}

