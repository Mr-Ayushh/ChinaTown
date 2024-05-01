
import './App.css'
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";

// import pages
import Home from "./pages/home"
import Faq from "./pages/faq"
import ContactPage from "./pages/contactUS"

function App() {
  
  return (
    <>
      <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/faq" element={<Faq />} />
        <Route path="/contact" element={<ContactPage />} />

      </Routes>
      </Router>
      
    </>
  )
}

export default App
