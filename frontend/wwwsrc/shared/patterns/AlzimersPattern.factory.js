export default function (Pattern, PatternAdvice) {
    let alziemersPattern = new Pattern('Alzheimers');

    alziemersPattern.addCondition((profile) => {
        return (profile.getTags().indexOf('Alzheimer\'s') !== -1)
    });

    alziemersPattern.addAdvice(new PatternAdvice('Check local Supermarkets', 'Studies conducted indicate that 6/25 missing people with Alzheimers were found in a local supermarket.'));
    alziemersPattern.addAdvice(new PatternAdvice('Check persons home', '1/8 missing people with Alzheimers were found in their own home.'));
    alziemersPattern.addAdvice(new PatternAdvice('Roads on route', '57% of missing people with Alzheimers were found on street roads.'));
    alziemersPattern.addAdvice(new PatternAdvice('5km Range', '90% of missing people with Alzheimers were found up to 5km from where last sighted.'));
    alziemersPattern.addAdvice(new PatternAdvice('Family Addresses', '28% of missing people with Alzheimers who were found in residential buildings, were found at family addresses.'));
    alziemersPattern.addAdvice(new PatternAdvice('Busses', '12% of missing people with Alzheimers were found on busses.'));

    alziemersPattern.setMapEffect({
        supermarkets: true,
        circle:{
            radius:5000,
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

    return alziemersPattern;
}