// Display and refresh the value of a stock
class Stock extends React.Component {

  constructor(props) {
    super(props);
    this.update_tick = 3000; // pull the stock price every 3 seconds
    this.state = props;
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
      this.update_tick
    );
  }

  componentWillUnmount() {
    clearInterval(this.timerID);
  }

  tick() {
    this.setState({
      value_now: Math.random()*100.0
    });
  }
}