#ifndef LITERALS_H
#define LITERALS_H

#include <QColor>
#include <QObject>
#include <QVariant>


class Literals : public QObject{
    Q_OBJECT
public:
//    explicit Literals(QObject *parent = Q_NULLPTR): QObject(parent){

//    }
    Q_INVOKABLE QVariant fontWeight(){return 65;}
    Q_INVOKABLE QVariant fontWeightLighter(){return 50;}
    Q_INVOKABLE QVariant fontWeightLarger(){return 85;}
    Q_INVOKABLE QVariant fontColor(){return "#eeffffff";}
    Q_INVOKABLE QVariant darkBackgroundColor(){return QColor(38,38,38);}
    Q_INVOKABLE QVariant chartBackgroundColor(){return   QColor( 133,195,96)  ;}
    Q_INVOKABLE QVariant transparent(){return   QColor( 0,0,0, 0)  ;}
    Q_INVOKABLE QVariant borderColor(){return   QColor( 76,76,76)  ;}
    Q_INVOKABLE QVariant borderWidth(){return  2 ;}
    Q_INVOKABLE QVariant buttonColor(){return   QColor( 76,76,76)  ;}
    Q_INVOKABLE QVariant buttonColorHovered(){return   buttonColor().value<QColor>().darker(105)  ;}
    Q_INVOKABLE QVariant buttonColorPressed(){return   buttonColor().value<QColor>().darker(250)  ;}
    Q_INVOKABLE QVariant blueButtonColor(){return QColor(0,176,229);}
    Q_INVOKABLE QVariant blueButtonColorHovered(){return   blueButtonColor().value<QColor>().darker(105) ;}
    Q_INVOKABLE QVariant blueButtonColorPressed(){return   blueButtonColor().value<QColor>().darker(250)  ;}
    Q_INVOKABLE QVariant switchOffColor(){return   QColor(90,90,90) ;}
    Q_INVOKABLE QVariant switchOnColor(){return   blueButtonColor().value<QColor>()  ;}
    Q_INVOKABLE QVariant animationLengthShort(){return   150  ;}
    Q_INVOKABLE QVariant animationLengthMedium(){return   500  ;}
    Q_INVOKABLE QVariant animationLengthLong(){return   750 ;}
};


#endif // LITERALS_H
