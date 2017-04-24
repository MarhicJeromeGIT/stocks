// Display and refresh the value of a stock
class Stock extends React.Component {

  constructor(props) {
    super(props);
    this.state = $.extend( props,
      {
        value_now_diff: 0
      }
    );
  }

  render() {
    return (
      <div>
        <ul className='list-group'>
          <StockValue title="Valorisation" value={this.state.value_now} />
          <StockValue title="Ouverture" value={this.state.value_open} />
          <StockValue title="Plus haut" value={this.state.value_high} />
          <StockValue title="Plus bas" value={this.state.value_low} />
        </ul>
      </div>
    );
  }

  // Setup a timer to refresh the stock value
  componentDidMount() {
    this.timerID = setInterval(
      () => this.tick(),
      5000
    );
  }

  componentWillUnmount() {
    clearInterval(this.timerID);
  }

  tick() {
    this.setState({
      value_now: Math.random()*100.0
    });
    //console.log(this.state.value_now);
  }
}