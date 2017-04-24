// Display and refresh the value of a stock
class StockValue extends React.Component {

  constructor(props) {
    super(props);
  }

  render() {
    return (
      <li className='list-group-item'>
        {this.props.title} :
        <div className='js-stock-value pull-right'>
          {format_value(this.props.value)}
        </div>
      </li>
    );
  }

  // Setup a timer to refresh the stock value
  componentDidMount() {
    console.log(this);
    //this.effect('highlight', 0, 500);
  }

  componentWillUnmount() {
    clearInterval(this.timerID);
  }

  componentWillReceiveProps(nextProps) {
    if(this.props.value < nextProps.value) {
      console.log("higher");
    }else if(this.props.value > nextProps.value) {
      console.log("smaller");
    }
  }
  
  tick() {
  }
}