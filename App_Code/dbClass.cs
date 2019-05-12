using System;

using System.Linq;
using System.Web;

/// <summary>
/// Summary description for dbClass
/// </summary>
public class dbClass
{
    public dbClass()
    {
    }

    public class Email
    {
        public string from
        {
            get
            {
                return m_from;
            }
            set
            {
                m_from = from;
            }
        }
        private string m_from;
        public string to
        {
            get
            {
                return m_to;
            }
            set
            {
                m_to = to;
            }
        }
        private string m_to;
        public string body
        {
            get
            {
                return m_body;
            }
            set
            {
                m_body = body;
            }
        }
        private string m_body;
        public string subject
        {
            get
            {
                return m_subject;
            }
            set
            {
                m_subject = subject;
            }
        }
        private string m_subject;
        public string direction
        {
            get
            {
                return m_direction;
            }
            set
            {
                m_direction = direction;
            }
        }
        private string m_direction;
        public string textAlign
        {
            get
            {
                return m_textAlign;
            }
            set
            {
                m_textAlign = textAlign;
            }
        }
        private string m_textAlign;
        public string textFloat
        {
            get
            {
                return m_textFloat;
            }
            set
            {
                m_textFloat = textFloat;
            }
        }
        private string m_textFloat;
    }
}