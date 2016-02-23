//Code for D3 Graph goes here

// ar rewards = [{
//   "date": "2016-02-18",
//   "amount": 50000,
// }, {
//   "date": "2016-01-18",
//   "amount": 40000,
// }, {
//   "date": "2015-12-18",
//   "amount": 30000,
// }];

// newDraw();
// window.setTimeout(newDraw, 2000);

// function newDraw() {

//   setGetX(rewards);
//   setGetY(rewards);

//   var points = d3.select('#SVG').selectAll('.points').data(rewards);

//   points.enter()
//     .append('circle');

//   points
//     .attr('r', 10)
//     .attr('cx', function(d) {
//       return getX(d.date);
//     })
//     .attr('cy', function(d) {
//       return getY(d.amount);
//     })
//     .classed('points', true);

//   points.on('mouseenter', makeTip);
//   points.on('mouseleave', killTip);
// }

// function makeTip(d, i, x) {
//   console.log(d, i, x);
// }

// function killTip(d, i, x) {
//   console.log(d, i, x);
// }

// function setGetX(data) {

//   const min = new Date('2015-11-01').getTime();
//   const max = new Date('2016-04-01').getTime();
//   //or
//   const min2 = _.minBy(data, function(d) {
//     return new Date(d.date).getTime();
//   })
//   const max2 = _.maxBy(data, function(d) {
//     return new Date(d.date).getTime();
//   })
//   console.log(min, max, min2, max2)

//   getX = function(date) {
//     const ms = new Date(date).getTime();
//     const x = (ms - min) / (max - min) * 200;
//     return x;
//   }
// }

// function setGetY(data) {
//   const min = 0;
//   const max = 60000;

//   getY = function(amount) {
//     const y = (amount - min) / (max - min) * 300;
//     console.log(y);
//     return y;
//   }
// }

// function getX() {}

// function getY() {}
