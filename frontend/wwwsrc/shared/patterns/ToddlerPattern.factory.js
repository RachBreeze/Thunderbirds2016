export default function (Pattern, PatternAdvice) {
    let toddlerPattern = new Pattern('Toddler');

    toddlerPattern.addCondition((profile) => {
        return (profile.getTags().indexOf('Toddler') !== -1)
    });

    toddlerPattern.addAdvice(new PatternAdvice('Check neighbours house', 'Missing toddlers are often found wondering local properties.'));

    toddlerPattern.setMapEffect({
        circle:{
            radius:100,
            stroke: {
                color: '#3964C3',
                weight: 1,
                opacity: 0.2
            },
            fill: {
                color: '#3964C3',
                opacity: 0.05
            }
        }
    })

    return toddlerPattern;
}