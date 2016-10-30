export default function () {
    class Pattern {
        constructor(name) {
            this.name = name;
            this.conditions = [];
            this.advice = [];
        }

        addCondition(conditionFunction) {
            this.conditions.push(conditionFunction);

            return this;
        }

        addAdvice(advice) {
            this.advice.push(advice);

            return this;
        }

        getAdvice () {
            return this.advice;
        }

        checkConditions(profile) {
            let success = false;

            let result = this.conditions.find((condition) => {
                return (condition(profile) === false);
            });

            return (result === undefined);
        }

        setMapEffect(map) {
            this.mapEffect = map;
        }

        getMapEffect () {
            return this.mapEffect;
        }

        getAdvice () {
            return this.advice;
        }
    }
    
    return Pattern;
}