export default function resolveFn(state, property) {
    return state.resolve[property][state.resolve[property].length-1];
}
