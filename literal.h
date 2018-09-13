#ifndef LITERAL_H
#define LITERAL_H

#include <QColor>
#include <QObject>
#include <QVariant>

class Literal : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariant fontWeight READ fontWeight CONSTANT)
    Q_PROPERTY(QVariant fontWeightLighter READ fontWeightLighter CONSTANT)
    Q_PROPERTY(QVariant fontWeightLarger READ fontWeightLarger CONSTANT)
    Q_PROPERTY(QVariant borderWidth READ borderWidth CONSTANT)
    Q_PROPERTY(QVariant fontcolor READ fontColor CONSTANT)
    Q_PROPERTY(QVariant blueButtonColor READ blueButtonColor CONSTANT)
    Q_PROPERTY(QVariant darkBackgroundColor READ darkBackgroundColor CONSTANT)
    Q_PROPERTY(QVariant chartBackgroundColor READ chartBackgroundColor CONSTANT)
    Q_PROPERTY(QVariant transparent READ transparent CONSTANT)
    Q_PROPERTY(QVariant borderColor READ borderColor CONSTANT)

    Q_PROPERTY(QVariant buttonColor READ borderColor CONSTANT)
    Q_PROPERTY(QVariant buttonColorHovered READ buttonColorHovered CONSTANT)
    Q_PROPERTY(QVariant buttonColorPressed READ buttonColorPressed CONSTANT)
    Q_PROPERTY(QVariant blueButtonColorHovered READ blueButtonColorHovered CONSTANT)
    Q_PROPERTY(QVariant blueButtonColorPressed READ blueButtonColorPressed CONSTANT)
    Q_PROPERTY(QVariant switchOffColor READ switchOffColor CONSTANT)
    Q_PROPERTY(QVariant switchOnColor READ switchOnColor CONSTANT)

    Q_PROPERTY(QVariant animationLengthShort READ animationLengthShort CONSTANT)
    Q_PROPERTY(QVariant animationLengthMedium READ animationLengthMedium CONSTANT)
    Q_PROPERTY(QVariant animationLengthLong READ animationLengthLong CONSTANT)


public:
    explicit Literal(QObject *parent = nullptr);

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
signals:

public slots:
};

#endif // LITERAL_H
