const items = [];
module.exports = {
  list: () => items,
  add: (amount, category) => items.push({ amount, category }),
};
